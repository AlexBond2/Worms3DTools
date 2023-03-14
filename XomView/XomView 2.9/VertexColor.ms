function WriteColor file clr =
(
WriteByte file (clr.x * 255 as Integer)
WriteByte file (clr.y * 255 as Integer)
WriteByte file (clr.z * 255 as Integer)
)

function WriteVector file p =
(
WriteFloat file p.x
WriteFloat file p.y
WriteFloat file p.z	
)

function WriteVColor file mesh =
( 	
	         num = mesh.numverts
		WriteLong file num 
		
		print num
		for a = 1 to num do
			   (
			   vert = (GetVert mesh a) --*InvWorldTM
			   WriteVector file vert		   
			   )	
			   
		num  = meshop.getNumFaces mesh 
		WriteLong file num 	
		print num	
		for a = 1 to num do
      		(
         		f = (GetFace mesh a) - [1, 1, 1]
         		WriteShort file (f.x as Integer)
         		WriteShort file (f.y as Integer)
         		WriteShort file (f.z as Integer)
      		)
			
		WriteLong file num 		   
          	for a = 1 to num do 
				(
				f = meshop.getMapFace $ 0 a
				clr = meshop.getmapvert mesh 0 f.x 
			 	WriteColor file clr
				clr = meshop.getmapvert mesh 0 f.y 
			 	WriteColor file clr
				clr = meshop.getmapvert mesh 0 f.z 
			 	WriteColor file clr				
				)
		
)

rollout VColor "Vertex Color" width:162 height:61
(
	button btn1 "Save Vertex Color" pos:[29,15] width:107 height:30
	on btn1 pressed  do
	(
	FileName = GetSaveFileName types:"Vertex Color file (*.vc)|*.vc"
	if (FileName != undefined) do
				(
					file = fopen FileName "wb" 
		    		           WriteVColor file $
					fclose file
				)
	)
)addRollout VColor 
