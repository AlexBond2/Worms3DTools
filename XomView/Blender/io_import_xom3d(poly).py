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
import array

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

        return XBoneEmpty         
    
    
#    "GS"(
#    )
    if (xtype=="SH" or xtype=="SS"):
     # obj
        numface = ReadShort(file)  # faces
        print (numface)                
        vert_array = []
        face_array = []
        faces = []
        
        for a in range (numface): 
            v1,v2,v3 = ReadShort(file),ReadShort(file),ReadShort(file)
            face_array.append([v1,v2,v3,0])
            faces.append([v1,v2,v3])
    
        num = ReadShort(file)  # vertex
        for a in range (num):
             vert_array.extend([ReadFloat(file),ReadFloat(file),ReadFloat(file)])

        m = bpy.data.meshes.new(xomname)
        
        m.vertices.add(num)
        #m.tessfaces.add(numface)
        m.loops.add(numface*3)
        m.polygons.add(numface)
        m.vertices.foreach_set("co", vert_array)
        #for i in range(numface):
        #    m.tessfaces[i].vertices_raw = face_array[i]
            
        loops_vert_idx = []
        faces_loop_start = []
        faces_loop_total = []
        lidx = 0
        for f in faces:
            vidx = f
            nbr_vidx = len(vidx)
            loops_vert_idx.extend(vidx)
            faces_loop_start.append(lidx)
            faces_loop_total.append(nbr_vidx)
            lidx += nbr_vidx
        m.loops.foreach_set("vertex_index", loops_vert_idx)
        m.polygons.foreach_set("loop_start", faces_loop_start)
        m.polygons.foreach_set("loop_total", faces_loop_total) 
          
        #m.tessfaces.foreach_set("vertices_raw",  face_array)
        #m.from_pydata(vert_array, [], face_array)
        
        isnormal = ReadBool(file)
        if isnormal:
            m.create_normals_split()
            #for fi in range(numface):
            #m.polygons.foreach_set("use_smooth", [True] * len(m.polygons))
             #   m.tessfaces[fi].use_smooth = True            
            norm_array = []            
            for a in range(num):                  
                norm_array.append([ReadFloat(file),ReadFloat(file),ReadFloat(file)])            
            for l in m.loops:
                    l.normal[:] = norm_array[l.vertex_index] 
            #print(norm_array)
            
        iscolor = ReadBool(file)
        if iscolor :
            print('color')
            color_arr = []            
            for a in range(num):                
               color_arr.append(ReadColor(file))
            
            vcolor = m.vertex_colors.new()
            for p in m.polygons:
                for lidx in p.loop_indices:
                    vcolor.data[lidx].color = color_arr[m.loops[lidx].vertex_index]                   
                    
            m.vertex_colors.active = vcolor
            
        istextcoord = ReadBool(file)
        if istextcoord:    
            #set UV            
            uv_coord = []
            for i in range(num):                             
                u = ReadFloat(file)
                v = ReadFloat(file)
                #print(i,u,v)
                uv_coord.append([u,v])

            m.uv_textures.new()  
            uvs=m.uv_layers[0] 
            for p in m.polygons:  
                p.material_index = 0                
                for lidx in p.loop_indices:
                    uvs.data[lidx].uv = uv_coord[m.loops[lidx].vertex_index]
             
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
                for uv_text in m.uv_textures[0].data:  
                    uv_text.image = image
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
        if isnormal:           
            m.validate(clean_customdata=False)
            m.update(calc_edges=False)            
            clnors = array.array('f', [0.0] * (len(m.loops) * 3))
            m.loops.foreach_get("normal", clnors)  
            m.polygons.foreach_set("use_smooth", [True] * len(m.polygons))
            m.normals_split_custom_set(tuple(zip(*(iter(clnors),) * 3)))
            m.use_auto_smooth = True
            m.show_edge_sharp = True
        return AddGeometry(m)
            
    if (xtype == "SK"):
     # skin
       childs = ReadShort(file)
       XGroup = AddDummy(xomname) 
       XBones = AddDummy('XBones') 
       XBone = ReadXNode(file)
       XBone.parent = XBones
       XBones.parent = XGroup   
       for a in range(1,childs):
           Skins = ReadXNode(file)
           Skins.parent = XGroup
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

def xom3dimport(infile,xom3dsize):
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
        size = xom3dsize
        mat =  Matrix(((0,0,size,0),(size,0,0,0),(0,size,0,0),(0,0,0,1)))
        XGroup.matrix_local = mat
        scene.update()
    else:
        print("Bad Xom3DModel format!!!")
        

#End of def xom3dimport#########################

def getInputFilenameXom3d(self, filename,xom3dsize):
    print ("------------",filename)
    xom3dimport(filename,xom3dsize)

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
            
    xom3dsize = FloatProperty(
            name="Size Factor",
            description="Size of import model",
            default=0.025,
            min=0.001,
            max=1,
            )            
            
    def execute(self, context):
        global scene
        scene = context.scene    
        getInputFilenameXom3d(self,self.filepath,self.xom3dsize)
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
