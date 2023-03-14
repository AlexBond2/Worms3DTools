global Filename

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

function ReadColor file = 
(
return color (ReadByte file #unsigned)(ReadByte file #unsigned)(ReadByte file #unsigned)  
)

function ReadBool file = (ReadByte file)>0

function ReadXNode file = 
(		-- begin node
		local xomname = ReadString file 
		print xomname
		local trmatix = matrix3 [ReadFloat file, ReadFloat file, ReadFloat file] \
		[ReadFloat file, ReadFloat file, ReadFloat file] \
		[ReadFloat file, ReadFloat file, ReadFloat file] \
		[ReadFloat file, ReadFloat file, ReadFloat file]
		local a

		local numface = ReadShort file  -- faces
		print numface
		if numface>0 then
		( -- obj
		
			local vert_array = #()
			local face_array = #() 
			
			for a = 1 to numface do 
		    	append face_array [(ReadShort file)+1,(ReadShort file)+1,(ReadShort file)+1] 
		
			local num = ReadShort file  -- vertex
			for a = 1 to num do 
		 		 append vert_array [ReadFloat file, ReadFloat file, ReadFloat file] 
	
			local m = mesh name:xomname vertices:vert_array faces:face_array transform:trmatix 
		
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
			 	meshop.setVertColor m 0 a (ReadColor file)	
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
			newmat.diffuseMap.map1 = Bitmaptexture fileName:textname
			if newmat.diffuseMap.map1.alphasource == 0 do 
				(
				newmat.opacityMap = Bitmaptexture fileName:textname
				newmat.opacityMap.monoOutput = 1
				newmat.twoSided = on
				)
			)
			
		if iscolor do (	
			newmat.diffuseMap.map2 = Vertex_Color ()
			if (getVertColor m 1) == black do 
					newmat.diffuseMap.map2Enabled = off
			)
			
		showTextureMap newmat on 
		m.material = newmat
	
			return m
		) 
		else
		( -- group
		   local childs = ReadShort file
		   local XGroup = dummy name:xomname boxsize: [1,1,1]  

		 if childs >0 do
		   for a = 1 to childs do (ReadXNode file).parent = XGroup 

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
				vert = (GetNormal mesh a)*InvWorldTM
			    WriteVector file vert	
				)
				
		iscolor = (mesh.material.diffuseMap.map2 != undefined)
		
		if iscolor then (
			WriteByte file 1
			for a = 1 to num do 
			 	WriteColor file (getVertColor mesh a)	
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

rollout XomRollout "Xom 3D Model Loader" width:179 height:150
(
	button btn2 "Open *.xom3d" pos:[38,50] width:88 height:36
	label lbl1 "Xom 3D Model Loader v.1.1" pos:[16,10] width:138 height:17
	label lbl2 "AlexBond (c) 2009" pos:[33,26] width:88 height:16
	button btn5 "X" pos:[125,26] width:19 height:15
	button btn3 "Save *.xom3d" pos:[37,93] width:88 height:36
	on btn2 pressed do
	(
		FileName = GetOpenFileName types:"Xom 3DModel (*.xom3d)|*.xom3D"
		if (FileName != undefined) do
		(
		file = fopen FileName "rb" 
		XGroup = dummy name:"Xom3DModel" boxsize: [1,1,1]     
		trmatix = matrix3 [1, 0, 0] [0, 0, 1] [0, 1, 0] [0, 0, 0]	
		(ReadXNode file).parent = XGroup 
		XGroup.transform = trmatix
		select XGroup	
		max tool zoomextents all
		fclose file
		)
	)
	on btn5 pressed do
		removeRollout XomRollout
	on btn3 pressed do
	(
		if ((classOf $)== Dummy)and($.name == "Xom3DModel") then (
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
		)
	)
)
addRollout XomRollout


