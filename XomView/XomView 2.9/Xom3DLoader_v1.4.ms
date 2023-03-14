global Filename
global XMat = 1
global tpos = 258
global trot = 259
global tresca = 260
global tsca = 2308
global tvis = 4352
global p_x = 0
global p_y = 256
global p_z = 512
global ControllersCount = 0
global tmul = 100
global XomRollout

function WriteVector file p =
(
WriteFloat file p.x
WriteFloat file p.y
WriteFloat file p.z	
)

function WriteMatrix file trmatrix =
(
WriteVector file trmatrix.row1
WriteVector file trmatrix.row2
WriteVector file trmatrix.row3
WriteVector file trmatrix.row4
)

function WriteColor file clr =
(
WriteByte file (clr.r as Integer)
WriteByte file (clr.g as Integer)
WriteByte file (clr.b as Integer)
)

function WriteColor2 file clr =
(
WriteByte file (clr.x*255 as Integer)
WriteByte file (clr.y*255 as Integer)
WriteByte file (clr.z*255 as Integer)
)

function ReadColor file = 
(
return color (ReadByte file #unsigned)(ReadByte file #unsigned)(ReadByte file #unsigned)  
)

function ReadBool file = (ReadByte file)>0

function WriteXController file objname controller PRSType XYZType =
(
 		 WriteString file objname
		 WriteShort file PRSType 
		 WriteShort file XYZType 
		 print controller
		 nkeys = controller.keys.count
		 WriteShort file nkeys
		 for i = 1 to nkeys do
			(

			WriteFloat file (controller.keys[i].inTangentLength * 3) 
			WriteFloat file controller.keys[i].inTangent
			
			WriteFloat file (controller.keys[i].outTangentLength * 3) 
			WriteFloat file controller.keys[i].outTangent
			
			WriteFloat file (controller.keys[i].time / tmul) 
						
			case PRSType  of (
				tpos: WriteFloat file controller.keys[i].value	
				trot: WriteFloat file (controller.keys[i].value*pi/180)
				tsca: WriteFloat file (controller.keys[i].value/100)	
	     		)		
			)
)

function  WriteXAnimNode file node =
(
		if node.pos.isAnimated do (
		    if node.pos.controller.x_position.isAnimated do 
				WriteXController file node.name node.pos.controller.x_position.controller tpos p_x
		    if node.pos.controller.y_position.isAnimated do 
				WriteXController file node.name node.pos.controller.y_position.controller tpos p_y
		    if node.pos.controller.z_position.isAnimated do 
				WriteXController file node.name node.pos.controller.z_position.controller tpos p_z				
		)
		if node.rotation.isAnimated do (
		    if node.rotation.controller.x_rotation.isAnimated do 
				WriteXController file node.name node.rotation.controller.x_rotation.controller trot p_x
		    if node.rotation.controller.y_rotation.isAnimated do 
				WriteXController file node.name node.rotation.controller.y_rotation.controller trot p_y
		    if node.rotation.controller.z_rotation.isAnimated do 
				WriteXController file node.name node.rotation.controller.z_rotation.controller trot p_z				
		)		
		if node.scale.isAnimated do (
		    if node.scale.controller.x_scale.isAnimated do 
				WriteXController file node.name node.scale.controller.x_scale.controller tsca p_x
		    if node.scale.controller.y_scale.isAnimated do 
				WriteXController file node.name node.scale.controller.y_scale.controller tsca p_y
		    if node.scale.controller.z_scale.isAnimated do 
				WriteXController file node.name node.scale.controller.z_scale.controller tsca p_z				
		)
		
		local childs = node.children.count 

		if childs >0 do
			for a = 1 to childs do
				WriteXAnimNode file node.children[a]
)

function  GetXAnimCount node =
(
	
		if node.pos.isAnimated do (
		    if node.pos.controller.x_position.isAnimated do 
				ControllersCount += 1		
		    if node.pos.controller.y_position.isAnimated do 
				ControllersCount += 1		
		    if node.pos.controller.z_position.isAnimated do 
				ControllersCount += 1				
		)
		if node.rotation.isAnimated do (
		    if node.rotation.controller.x_rotation.isAnimated do 
				ControllersCount += 1		
		    if node.rotation.controller.y_rotation.isAnimated do 
				ControllersCount += 1		
		    if node.rotation.controller.z_rotation.isAnimated do 
				ControllersCount += 1					
		)		
		if node.scale.isAnimated do (
		    if node.scale.controller.x_scale.isAnimated do 
				ControllersCount += 1		
		    if node.scale.controller.y_scale.isAnimated do 
				ControllersCount += 1		
		    if node.scale.controller.z_scale.isAnimated do 
				ControllersCount += 1					
		)
		
		local childs = node.children.count 

		if childs >0 do
			for a = 1 to childs do
				GetXAnimCount node.children[a]
)

function SaveXAnim file node =
(
		animname = XomRollout.edt1.text
		WriteString file animname
		WriteFloat file (animationRange.end/tmul)
		ControllersCount = 0
		GetXAnimCount node
		print ControllersCount 
		WriteShort file ControllersCount -- unknown count
		WriteXAnimNode file node
)

function LoadXAnim file =
(
		animname = ReadString file 
		print animname 
		XomRollout.edt1.text = animname 
--		deleteKeys 
	    maxkey = ReadFloat file
		num = ReadShort file 
		for a = 1 to num do
		 (
		 objname = ReadString file
		 PRSType = ReadShort file
		 XYZType = ReadShort file
		 s = "$"+ objname
	     obj = execute (s)
		 print obj
		 print XYZType
		 controller = bezier_float()  	
	 
		 case PRSType of
		 (
			tpos : 
			(
			obj.pos.controller = Position_XYZ()
				case XYZType of
				(
				p_x: obj.pos.controller.x_position.controller = controller            
				p_y: obj.pos.controller.y_position.controller = controller    
				p_z: obj.pos.controller.z_position.controller = controller    
				) 
			)
			trot : 
			(
			obj.rotation.controller = Euler_XYZ()
				case XYZType of
				(
				p_x: obj.rotation.controller.x_rotation.controller = controller            
				p_y: obj.rotation.controller.y_rotation.controller = controller    
				p_z: obj.rotation.controller.z_rotation.controller = controller    
				) 
			)			
			tsca:
			(
			obj.scale.controller = ScaleXYZ()
				case XYZType of
				(
				p_x: obj.scale.controller.x_scale.controller = controller            
				p_y: obj.scale.controller.y_scale.controller = controller    
				p_z: obj.scale.controller.z_scale.controller = controller    
				) 
			)		
			tresca :
			(
			obj.scale.controller = ScaleXYZ()
				case XYZType of
				(
				p_x: obj.scale.controller.x_scale.controller = controller            
				p_y: obj.scale.controller.y_scale.controller = controller    
				p_z: obj.scale.controller.z_scale.controller = controller    
				) 
			)		
 
 
			tvis : obj.material.opacity = controller            
		)	

		 keys = ReadShort file
		 for b = 1 to keys do
			(
			key = addNewKey controller 1000f
			
			key.inTangentType = #custom
			key.outTangentType = #custom
			key.x_locked = false
			inTangentLength = (ReadFloat file)/3
			inTangent = ReadFloat file
			outTangentLength = (ReadFloat file)/3
			outTangent = ReadFloat file
			ktime =  ReadFloat file
			value =  ReadFloat file
		--	outTangentLength = 0.33f
		--	inTangentLength = 0.33f
			
			format "[%; %; %; %; %; %]" inTangent inTangentLength outTangent outTangentLength ktime value 
		--	key.inTangent = inTangent -- / tmul 
		--	key.inTangentLength =  inTangentLength	
		--	key.outTangent = outTangent -- / tmul 
		--	key.outTangentLength =  outTangentLength
			key.time = ktime * tmul
		--	if maxkey<key.time then maxkey = key.time 
		case PRSType  of (
		tpos: key.value = value	
		trot: key.value = value/pi*180
		tresca: key.value = value*100	
		tsca: key.value = value*100	
	     )			
			print key
		   -- format "[%; %; %; %]\n" key.inTangent key.inTangentLength key.outTangent key.outTangentLength  

			) 
		 )
		 maxkey = maxkey*100
		animationRange = interval 0 maxkey
)

function ReadXNode file = 
(		-- begin node
		local xtype = ReadString file 
		print xtype
		
		if (xtype=="XN") then (
		  local XGroup = dummy name:"XNone" boxsize: [1,1,1]  
    	  return XGroup 		
		)
		
		local xomname = ReadString file 
		print xomname

		matrixtype = ReadByte file
		case matrixtype of
		(
		1:(
		local trmatix = matrix3 [ReadFloat file, ReadFloat file, ReadFloat file] \
		[ReadFloat file, ReadFloat file, ReadFloat file] \
		[ReadFloat file, ReadFloat file, ReadFloat file] \
		[ReadFloat file, ReadFloat file, ReadFloat file]
		)
		2:(
		local pos = point3 (ReadFloat file) (ReadFloat file) (ReadFloat file) 
		local rot = eulerToQuat (eulerAngles (radToDeg(ReadFloat file)) (radToDeg(ReadFloat file)) (radToDeg(ReadFloat file))) 
		local size = point3 (ReadFloat file) (ReadFloat file) (ReadFloat file) 
		local trmatix = (rotate (scaleMatrix size) rot) * (transMatrix pos)
		)
		3:(
		local pos = point3 (ReadFloat file) (ReadFloat file) (ReadFloat file) 
		local rot = eulerToQuat (eulerAngles (radToDeg(ReadFloat file)) (radToDeg(ReadFloat file)) (radToDeg(ReadFloat file))) 
		local jointorient = eulerToQuat (eulerAngles (radToDeg(ReadFloat file)) (radToDeg(ReadFloat file)) (radToDeg(ReadFloat file))) 		
		local rotorient = eulerToQuat (eulerAngles (radToDeg(ReadFloat file)) (radToDeg(ReadFloat file)) (radToDeg(ReadFloat file))) 
		local size = point3 (ReadFloat file) (ReadFloat file) (ReadFloat file) 
		--local trmatix = (rotate (scaleMatrix size) rot) * (transMatrix pos)

		local trmatix = (rotate(rotate(rotate (scaleMatrix size) rotorient )jointorient ) rot)* (transMatrix pos)

	--	local trmatix2 = matrix3 [ReadFloat file, ReadFloat file, ReadFloat file] \
	--	[ReadFloat file, ReadFloat file, ReadFloat file] \
	--	[ReadFloat file, ReadFloat file, ReadFloat file] \
	--	[ReadFloat file, ReadFloat file, ReadFloat file]
		--trmatix = inverse trmatix2 
	--	print trmatrix
	--	local zero = ReadByte file	
		)
		)
		local a
		
		if (xtype=="GO") do (
			--	ObjectX = mesh name:xomname vertices:#() faces:#() 
				local childs = ReadShort file
	
				-- child #1
				xomnameSH = ReadString file 
				xtypeSH = ReadString file 
				ismatrixSH = ReadBool file
			---	numfaceSH = ReadShort file  
				childsSH = ReadShort file
				
				ObjectX = (ReadXNode file)
				ObjectX.name = xomname 
				
	   			for a = 2 to childsSH do attach ObjectX (ReadXNode file)
				
				ObjectX.material.name = xomname + "_shader" 
				--meditMaterials[XMat] = ObjectX.material
				XMat += 1 
		   		for a = 2 to childs do (ReadXNode file).parent = ObjectX 
				
				ObjectX.transform = trmatix 
		   		return ObjectX 
			  )
			  
	    if (xtype=="BG") do (
		   local childs = ReadShort file			   
		   local XBone = point name:xomname constantscreensize:on
		   -- child #1 BO
		--   local childs = ReadShort file
	 
		  for a = 1 to childs do in XBone (ReadXNode file)
		   if matrixtype>0 do
		   		XBone.transform = trmatix		
	
		   return XBone 		
		)
		
	--	"GS"(
	--	)
	    if (xtype=="SH")or(xtype=="SS") do 
		( -- obj
		local numface = ReadShort file  -- faces
		print numface				
			local vert_array = #()
			local face_array = #() 
			
			for a = 1 to numface do 
		    	append face_array [(ReadShort file)+1,(ReadShort file)+1,(ReadShort file)+1] 
		
		local num = ReadShort file  -- vertex
			for a = 1 to num do 
		 		 append vert_array [ReadFloat file, ReadFloat file, ReadFloat file] 
	
			local m = mesh name:xomname vertices:vert_array faces:face_array 
		
			isnormal = ReadBool file
			if isnormal do
			(
				for a = 1 to num do 
					(
				    nvect = point3 (ReadFloat file) (ReadFloat file) (ReadFloat file)
					setNormal m a nvect					
					)
			)
				
		iscolor = ReadBool file
		if iscolor do (
		     	for a = 1 to num do 
				(
				clr = ReadColor file
			 	meshop.setVertColor m 0 a clr
			--	format "%. %\n" a clr
				)	
			--	m.showVertexColors true
				)

		istextcoord = ReadBool file
		if istextcoord do		
		(
			--set UV
			setNumTVerts m num
			for i = 1 to num do (setTVert m i [(ReadFloat file),(ReadFloat file),0])
			buildTVFaces m false
			for i = 1 to numface do (setTVFace m i face_array [i]) 
		)		
		ismat = ReadBool file
		if ismat then
			(
			newmat = Standardmaterial name: (ReadString file)
			newmat.adTextureLock = off
			newmat.ambient = ReadColor file
			newmat.diffuse = ReadColor file
			newmat.specular = ReadColor file
			newmat.specularLevel = 100
			newmat.useSelfIllumColor = on
			newmat.selfIllumColor = ReadColor file
			-- twoSided                
			)
		else
			(
			newmat = Standardmaterial prefix:"XMaterial" 
			newmat.diffuse = color 255 255 255
			)
		
		newmat.diffuseMap = RGB_Multiply ()
		
		istexture = ReadBool file	
		if istexture do
			(
			textname = (getFilenamePath FileName) + ReadString file 
	    -- 	textname = ReadString file 
			newmat.diffuseMap = Bitmaptexture fileName:textname
			if newmat.diffuseMap.alphasource == 0 do 
				(
				newmat.opacityMap = Bitmaptexture fileName:textname
				newmat.opacityMap.monoOutput = 1
				newmat.twoSided = on
				)
			)
			
	--	if iscolor do (	
	--		newmat.diffuseMap.map2 = Vertex_Color ()
	--		if (getVertColor m 1) == black do 
	--				newmat.diffuseMap.map2Enabled = off
	--		)
			
		showTextureMap newmat on 
		m.material = newmat
		
		if (xtype == "SS") do (
		
			theSkin = Skin()
			Max Modify Mode
			modPanel.setCurrentObject m
			addModifier m theSkin
			
			local k = ReadShort file  -- bones
			for a = 1 to k do (
	     			boneobj = getNodeByName (ReadString file)
					print boneobj
					skinOps.addbone theSkin boneobj 1
					)
			completeRedraw ()
			for a = 1 to num do 	
					for b = 1 to k do 
						skinOps.SetVertexWeights theSkin a b (ReadFloat file)

			)
			
			return m
		) 	
		if (xtype == "SK") do 		
		( -- skin
		   local childs = ReadShort file
		   local XGroup = dummy name:xomname boxsize: [1,1,1]  
		   XBone = point name:"XBones" constantscreensize = on
		   in XBone (ReadXNode file)
		   XBone.parent = XGroup
		   for a = 2 to childs do 
				(ReadXNode file).parent = XGroup 
		   if matrixtype>0  do
		   		XGroup.transform = trmatix		
		   return XGroup 		
		)	
		( -- group
		   local childs = ReadShort file
		   format "% - % have %\n" xtype xomname childs
		   local XGroup = dummy name:xomname boxsize: [1,1,1]  

		 if childs >0 do
		   for a = 1 to childs do 
		   		(
				format "child %" a 
				obj = ReadXNode file
				--if (classOf obj) != bone do	
				obj.parent = XGroup 
				)
		   if matrixtype>0  do
		   		XGroup.transform = trmatix		
		   return XGroup 
		)	
	
		
)	-- end node

function WriteXNode file node = 
(		-- begin node

		WriteString file node.name
		print node.name
		WriteMatrix file (node.transform * ( inverse node.parent.transform ))

		local a
		local numface -- faces
		if  ((classOf node) == Editable_Mesh) then 
			(
				numface = node.numfaces
				local mesh = node
			)
			else
			(
				numface = 0
			)
			
		WriteShort file numface 
		print numface
		if numface>0 then
		( -- obj

			for a = 1 to numface do
      		(
         		f = (GetFace mesh a) - [1, 1, 1]
         		WriteShort file (f.x as Integer)
         		WriteShort file (f.y as Integer)
         		WriteShort file (f.z as Integer)
      		)
		
		local num = mesh.numverts
				WriteShort file num -- vertex
				
		worldTM = mesh.transform
		InvWorldTM = inverse worldTM
		
			for a = 1 to num do
			   (
			   vert = (GetVert mesh a)*InvWorldTM
			   WriteVector file vert		   
			   )
	
		--	isnormal = ReadBool file ??
		WriteByte file 1
	--	if isnormal do
			for a = 1 to num do
				(
				vert = (GetNormal mesh a) --*InvWorldTM
			    WriteVector file vert	
				)
				
		iscolor = (mesh.material.diffuseMap.map2 != undefined)
		
		if iscolor then (
			WriteByte file 1
			for a = 1 to num do 
				(
				clr = getVertColor mesh a	
			 	WriteColor file clr
			--	format "%. %\n" a clr
				)	
			 				
				--WriteColor2 file (meshop.getVDataValue mesh 0 a)	
				--WriteColor2 file (meshop.getMapVert mesh 0 a)	
		) else WriteByte file 0

		 istextcoord = (mesh.material.diffuseMap.map1 != undefined)
	
		if istextcoord then	
		(
			WriteByte file 1
		for a = 1 to num do (
			t = (GetTVert mesh a)   
            WriteFloat file t.x
            WriteFloat file t.y  --(1 - t.y)   -- отображаем координату по Y
			)
		) else WriteByte file 0
		
		ismat = (mesh.material != undefined)
		if ismat then
			(
			WriteByte file 1 
			WriteString file mesh.material.name
			WriteColor file mesh.material.ambient
			WriteColor file mesh.material.diffuse
			WriteColor file mesh.material.specular
			WriteColor file mesh.material.selfIllumColor
			)
			else
			(
			WriteByte file 0 
			)
		
		istexture = (mesh.material.diffuseMap.map1 != undefined)

		if istexture then
			(
			WriteByte file 1 
			textname = mesh.material.diffuseMap.map1.fileName
			WriteString file (filenameFromPath textname) 
			) else WriteByte file 0 
			
		) 
		else
		( -- group
				
			local childs = node.children.count 
			WriteShort file childs
			
		 if childs >0 do
			for a = 1 to childs do
				WriteXNode file node.children[a]

		)			
		
)	-- end node

rollout XomRollout "Xom 3D Model Loader" width:179 height:212
(
	button btn2 "Open *.xom3d" pos:[37,50] width:88 height:20
	label lbl1 "Xom 3D Model Loader v.1.4" pos:[16,10] width:138 height:17
	label lbl2 "AlexBond (c) 2013" pos:[33,26] width:88 height:16
	button btn5 "X" pos:[125,26] width:19 height:15
	button btn3 "Save *.xom3d" pos:[37,74] width:88 height:18
	label lbl3 "Xom Animate Loader v.1.1" pos:[24,105] width:128 height:17
	button btn4 "Open *.xac" pos:[37,127] width:88 height:20
	button btn6 "Save *.xac" pos:[37,175] width:88 height:20
	edittext edt1 "Name" pos:[37,153] width:89 height:16
	on btn2 pressed do
	(
		FileName = GetOpenFileName types:"Xom 3DModel (*.xom3d)|*.xom3D"
		if (FileName != undefined) do
		(
		file = fopen FileName "rb" 
	
		FileType = ReadString file
		if FileType == "X3D" then
			(
			XMat = 1
			XGroup = dummy name:"Xom3DModel" boxsize: [1,1,1]     
			trmatix = matrix3 [0,1,0] [0,0,1] [1,0,0] [0,0,0]
			(ReadXNode file).parent = XGroup 
			XGroup.transform = trmatix
			select XGroup	
			) 
			else
			(
			messageBox "Bad Xom3DModel format!!!" 
			)
			
		max tool zoomextents all
		fclose file
		)
	)
	on btn5 pressed do
		removeRollout XomRollout
	on btn3 pressed do
	(
			messageBox "Sorry, this not work, while!" 

	/*	if ((classOf $)== Dummy)and($.name == "Xom3DModel") then (
			FileName = GetSaveFileName types:"Xom 3DModel (*.xom3d)|*.xom3D"
			if (FileName != undefined) do
			(
				file = fopen FileName "wb" 
	    		WriteXNode file $.children[1]
				fclose file
			)
		) 
		else
		(
			messageBox "You should select Xom3DModel for save!!!" 
		)*/
	)
	on btn4 pressed do
	(
		FileName = GetOpenFileName types:"Xom Anim Clip (*.xac)|*.xac"
		if (FileName != undefined) do
		(
		file = fopen FileName "rb" 
	    LoadXAnim file
		fclose file
		)
	)
	on btn6 pressed do
	(
		if ((classOf $)== Dummy)and($.name == "Xom3DModel") then (	
			FileName = GetSaveFileName types:"Xom Anim Clip (*.xac)|*.xac"
			if (FileName != undefined) do
			(
				file = fopen FileName "wb" 
	    		SaveXAnim file $.children[1]
				fclose file
			)
		) 
		else
		(
			messageBox "You should select Xom3DModel for save!!!" 
		)			
	)
)addRollout XomRollout

