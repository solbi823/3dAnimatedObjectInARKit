# 3D Animated Object In ARKit
This is how to add 3d animated object node in ARKit.

# Preprocess
1. Export .dae file.

2. Edit xml format by using xmllint by typing below command in terminal.
xmllint --format filename.dae > newFilename.dae

3. Another converting process by using Convert to XCodeCollada program.
Download and install from below link. You can convert the file by  right-clicking the file icon and 
clicking Service- ConvertToXcodeCollada.
https://drive.google.com/file/d/0B1_uvI21ZYGUaGdJckdwaTRZUEk/edit

4. Import converted file into art.scnassets folder. And also import texture file as .jpg or .png.

5. Set the model, especially texture part well. 
Choose the model in Scene graph, and go to Material inspector and set diffuse property as the texture file you imported.

# Run
Make new object node and trigger animation by using pushed code.
