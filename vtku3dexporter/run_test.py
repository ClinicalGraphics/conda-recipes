import vtk
import os
import vtku3dexporter
import tempfile


def write_u3d(file_path, actor):
    render_window = vtk.vtkRenderWindow()
    render_window.OffScreenRenderingOn()
    renderer = vtk.vtkRenderer()
    render_window.AddRenderer(renderer)
    renderer.AddActor(actor)
    renderer.ResetCamera()
    u3d_exporter = vtku3dexporter.vtkU3DExporter()
    u3d_exporter.SetFileName(file_path)
    u3d_exporter.SetInput(render_window)
    u3d_exporter.Write()

# Create cube
cube = vtk.vtkCubeSource()

# Mapper
cubeMapper = vtk.vtkPolyDataMapper()
cubeMapper.SetInputData(cube.GetOutput())

# Actor
cubeActor = vtk.vtkActor()
cubeActor.SetMapper(cubeMapper)

# Get the file_path and delete if it already exists
dir_path = tempfile.gettempdir()
filename = "Exported"
file_path = os.path.join(dir_path, filename)

if os.path.exists("{}.u3d".format(file_path)):
    print("removing old file...")
    os.remove("{}.u3d".format(file_path))

# Write the u3d file to the file path
print("writing file to {}.u3d".format(file_path))
write_u3d(file_path, cubeActor)

print("testing that u3d was generated...")
# Check that we have successfully created a U3D file
if not os.path.exists("{}.u3d".format(file_path)):
    raise Exception("Failed to create the U3D file")

print("test successful")
