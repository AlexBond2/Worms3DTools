bl_info = {
    "name": "Import Xom 3DModel",
    "author": "AlexBond",
    "version": (1, 0, 0),
    "blender": (2, 60, 0),
    "location": "File > Import > Import Xom 3DModel (.xom3d)",
    "description": "Import Xom 3DModel from XomView format (.xom3d).",
    "warning": "",
    "wiki_url": "",
    "category": "Import-Export",
}

import bpy
import mathutils
import math
import os

from mathutils import *
from math import *
from bpy.props import *
from string import *
from struct import *
from math import *
from bpy_extras.io_utils import unpack_list, unpack_face_list
from bpy_extras.image_utils import load_image

# -----------------------------------------------------------------------------
# Misc utils.

def transMatrix(v):
    return Matrix.Translation(v)

def scaleMatrix(v):
    mat = Matrix.Identity(4) 
    mat[0][0], mat[1][1], mat[2][2] = v[0],v[1],v[2]
    return mat

def rotateMatrix(v):
    rot = Euler(v,'XYZ').to_quaternion() 
    return rot.to_matrix().to_4x4()

def ReadVector(file):
    return Vector(unpack('3f', file.read(4*3)))

def ReadString(file):
    out = [] 
    while True: 
        ch = file.read(1)
        #print (ch)
        if ch==b'\x00': break
        out.append(ch.decode())
    return ''.join(out)

def ReadColor(file):
    color = unpack('3B', file.read(3))
    return [x / 255 for x in color] 

def ReadBool(file):
    return unpack('<?', file.read(1))[0]

def ReadShort(file):
    return unpack('<H', file.read(2))[0]

def ReadByte(file):
    return unpack('<B', file.read(1))[0]

def ReadFloat(file):
    return unpack('<f', file.read(4))[0]

def AddDummy(name):
    global scene
    dummy = bpy.data.objects.new(name,None)
    scene.objects.link(dummy)
    return dummy

def AddGeometry(m):
    global scene
    obj =  bpy.data.objects.new(m.name, m)
    obj.show_name = True
    scene.objects.link(obj)
    scene.objects.active = obj
    obj.select = True
    m.validate()
    m.update()
    return obj

def ReadXNode(file):#begin node
    global XMat, path

    xtype = ReadString(file)
    print (xtype)

    if (xtype == "XN"):
        XGroup = AddDummy('XNone')     
        return XGroup

    xomname = ReadString(file)
    print (xomname)

    matrixtype = ReadByte (file)
    print("transform", matrixtype)
    
    if (matrixtype==1):
        trmatix = Matrix(( (ReadFloat (file), ReadFloat(file), ReadFloat(file), 0),
		  (ReadFloat(file), ReadFloat(file), ReadFloat(file),0),
		  (ReadFloat(file), ReadFloat(file), ReadFloat(file),0),
		  (ReadFloat(file), ReadFloat(file), ReadFloat(file),0))).transposed()
    elif (matrixtype==2):
        pos = ReadVector(file)
        rot = ReadVector(file)
        size =  ReadVector(file)
        trmatix =  transMatrix(pos) * rotateMatrix(rot) * scaleMatrix(size)
    elif (matrixtype==3):
        pos = ReadVector(file)
        rot =  ReadVector(file)
        jointorient = ReadVector(file)	
        rotorient = ReadVector(file)
        size = ReadVector(file)
        trmatix = transMatrix(pos) * rotateMatrix(rot) * rotateMatrix(jointorient) * rotateMatrix(rotorient) * scaleMatrix(size) 		
    if matrixtype:
        print(trmatix)    
    if (xtype=="GO"):
        # ObjectX = mesh name:xomname vertices:#() faces:#() 
        childs = ReadShort(file)        
        XGroupObject = AddDummy(xomname)   
                     
        for a in range (childs): #parts
           ObjectX = ReadXNode(file) 
           ObjectX.parent = XGroupObject
            
        XGroupObject.matrix_local = trmatix 
        return XGroupObject 
          
    if (xtype=="BG"):
        childs = ReadShort(file)               
        XBoneEmpty = AddDummy(xomname)
        # child #1 BO
        # local childs = ReadShort(file)
 
        for a in range (childs):
          XBone = ReadXNode(file)
          XBone.parent = XBoneEmpty
         
        if matrixtype>0:
            XBoneEmpty.matrix_local = trmatix        

        return XBone         
    
    
#    "GS"(
#    )
    if (xtype=="SH" or xtype=="SS"):
     # obj
        numface = ReadShort(file)  # faces
        print (numface)                
        vert_array = []
        face_array = []
        
        for a in range (numface): 
            face_array.append([ReadShort(file),ReadShort(file),ReadShort(file),0])
    
        num = ReadShort(file)  # vertex
        for a in range (num):
             vert_array.extend([ReadFloat(file),ReadFloat(file),ReadFloat(file)])

        m = bpy.data.meshes.new(xomname)
        
        m.vertices.add(num)
        m.tessfaces.add(numface)
        
        m.vertices.foreach_set("co", vert_array)
        for i in range(numface):
            m.tessfaces[i].vertices_raw = face_array[i]
        #m.tessfaces.foreach_set("vertices_raw",  face_array)
        #m.from_pydata(vert_array, [], face_array)
        
        isnormal = ReadBool(file)
        if isnormal:
            #m.create_normals_split()
            #for fi in range(numface):
            #m.polygons.foreach_set("use_smooth", [True] * len(m.polygons))
             #   m.tessfaces[fi].use_smooth = True
            #m.validate(clean_customdata=False)
            #m.update(calc_edges=False)
            norm_array = []            
            for a in range(num):                  
                norm_array.append([ReadFloat(file),ReadFloat(file),ReadFloat(file)])            
            m.vertices.foreach_set("normal", unpack_list(norm_array))
            for l in m.loops:
                    l.normal[:] = norm_array[l.vertex_index]
            for i in range(numface): 
                m.tessfaces[i].use_smooth = True
            #m.normals_split_custom_set_from_vertices(norm_array)     
            #m.free_normals_split()
            #m.show_edge_sharp = True
            #print(norm_array)
            
        iscolor = ReadBool(file)
        if iscolor :
            print('color')
            color_arr = []
            vcol_lay = m.tessface_vertex_colors.new()
            for a in range(num):                
               color_arr.append(ReadColor(file))
            
            for i, f in enumerate(vcol_lay.data):
                # XXX, colors dont come in right, needs further investigation.
                ply_col = []
                ply_col.append(color_arr[face_array[i][0]])
                ply_col.append(color_arr[face_array[i][1]])
                ply_col.append(color_arr[face_array[i][2]])
                
                f_col = f.color1, f.color2, f.color3
                
                for j, col in enumerate(f_col):
                    col.r, col.g, col.b = ply_col[j]
        #    format "%. %\n" a clr
        #    m.showVertexColors true
            
        istextcoord = ReadBool(file)
        if istextcoord:    
            #set UV            
            uv_coord = []
            for i in range(num):                             
                u = ReadFloat(file)
                v = ReadFloat(file)
                #print(i,u,v)
                uv_coord.append([u,v])

            m.tessface_uv_textures.new()    
            for i in range(numface):  
                m.tessfaces[i].material_index = 0                
                tface = m.tessface_uv_textures[0].data[i]
                tface.uv1 = uv_coord[face_array[i][0]]
                tface.uv2 = uv_coord[face_array[i][1]]
                tface.uv3 = uv_coord[face_array[i][2]]
             
        ismat = ReadBool(file)
        if ismat:                
            newmat = bpy.data.materials.new(ReadString(file))
            newmat.mirror_color = ReadColor(file)
            newmat.diffuse_color = ReadColor(file)
            newmat.specular_color = ReadColor(file)
            newmat.specular_intensity = 1.0
        #    newmat.useSelfIllumColor = on
            selfIllumColor = ReadColor(file) # not used in Blender
            # twoSided              
        else:                
            newmat = bpy.data.materials.new("XMaterial") 
            newmat.diffuse_color = (1,1,1)                
    
        #newmat.diffuseMap = RGB_Multiply ()
    
        istexture = ReadBool(file)    
        if istexture:
            textname = ReadString(file)
            mtex = newmat.texture_slots.add()
            new_texture = bpy.data.textures.new('XTexture', type='IMAGE')
            image = load_image(textname,path)
            if image is not None:
                new_texture.image = image
                image_depth = image.depth
                for i in range(numface):
                    m.tessface_uv_textures[0].data[i].image = image
            mtex.texture = new_texture
            mtex.texture_coords = 'UV'
            mtex.use_map_color_diffuse = True
            
            if image_depth in {32, 128}:
                mtex.use_map_alpha = True
                new_texture.use_mipmap = True
                new_texture.use_interpolation = True
                image.use_alpha = True
                newmat.use_transparency = True
            
    #    if iscolor do (    
    #        newmat.diffuseMap.map2 = Vertex_Color ()
    #        if (getVertColor m 1) == black do 
    #                newmat.diffuseMap.map2Enabled = off
    #        )
            
       # showTextureMap newmat on 
        m.materials.append(newmat)
        
        if (xtype == "SS"):
                
            #theSkin = Skin()
            #Max Modify Mode
            #modPanel.setCurrentObject m
            #addModifier m theSkin
            
            k = ReadShort(file)  # bones
            for a in range(k):
                bone = ReadString(file)
                #boneobj = getNodeByName (ReadString(file))
                #    print boneobj
                #    skinOps.addbone theSkin boneobj 1
            
            # completeRedraw ()
            for a in range(num):
                for b in range(k):
                    weight = ReadFloat(file)
                    #skinOps.SetVertexWeights theSkin a b (ReadFloat(file))
        
        return AddGeometry(m)
            
    if (xtype == "SK"):
     # skin
       childs = ReadShort(file)
       XGroup = AddDummy(xomname)     
       #XBone = Object.New('XBones', xomname)
       XBone = ReadXNode(file)
       XBone.parent = XGroup
       for a in range(1,childs): 
            (ReadXNode(file)).parent = XGroup 
       if matrixtype>0:
            XGroup.matrix_local = trmatix        
       return XGroup         
        
    else: # group
       childs = ReadShort(file)
       print("%s - %s have %d" % (xtype, xomname, childs))
       XGroup = AddDummy(xomname)

       
       for a in range(childs):                       
           print ("child %d" % a )
           obj = ReadXNode(file)
           #if (classOf obj) != bone do    
           obj.parent = XGroup 
                
       if matrixtype>0:
                XGroup.matrix_local = trmatix    
       
       return XGroup     
    
# end node

def xom3dimport(infile):
    global scene, path
    
    print ("--------------------------------------------------")
    print ("---------SCRIPT EXECUTING PYTHON IMPORTER---------")
    print ("--------------------------------------------------")
    print ("Importing file: ", infile)

    xom3dfile = open(infile,'rb')
    path = os.path.dirname(infile)
    #read general header
    filetype = ReadString(xom3dfile)
    
    if filetype == "X3D":
        print("Correct file header")
        XGroup = AddDummy('Xom3DModel')
        ob = ReadXNode(xom3dfile)
        ob.parent = XGroup
        size = 0.025
        mat =  Matrix(((0,0,size,0),(size,0,0,0),(0,size,0,0),(0,0,0,1)))
        XGroup.matrix_local = mat
        scene.update()
    else:
        print("Bad Xom3DModel format!!!")
        

#End of def xom3dimport#########################

def getInputFilenameXom3d(self, filename):
    print ("------------",filename)
    xom3dimport(filename)

# -----------------------------------------------------------------------------
# Operator

class IMPORT_OT_xom3d(bpy.types.Operator):
    """Import Xom 3DModel from XomView format"""
    bl_idname = "import_scene.xom3d"
    bl_label = "Import Xom 3DModel"
    bl_region_type = "WINDOW"
    bl_options = {'UNDO'}

    # List of operator properties, the attributes will be assigned
    # to the class instance from the operator settings before calling.
    filepath = StringProperty(
            subtype='FILE_PATH',
            )
    filter_glob = StringProperty(
            default="*.xom3d",
            options={'HIDDEN'},
            )
    def execute(self, context):
        global scene 
        scene = context.scene    
        getInputFilenameXom3d(self,self.filepath)
        return {'FINISHED'}   
    def invoke(self, context, event):
        wm = context.window_manager
        wm.fileselect_add(self)
        return {'RUNNING_MODAL'}

# -----------------------------------------------------------------------------
# Register
def import_xom3d_button(self, context):
    self.layout.operator(IMPORT_OT_xom3d.bl_idname,
                         text="Xom 3DModel (.xom3d)")


def register():
    bpy.utils.register_module(__name__)
    bpy.types.INFO_MT_file_import.append(import_xom3d_button)


def unregister():
    bpy.utils.unregister_module(__name__)
    bpy.types.INFO_MT_file_import.remove(import_xom3d_button)
print('ok')

if __name__ == "__main__":
    register()
