import vtk
import os
import vtku3dexporter
import tempfile


def write_u3d(destination_folder, filename, actor):
    render_window = vtk.vtkRenderWindow()
    render_window.OffScreenRenderingOn()
    renderer = vtk.vtkRenderer()
    render_window.AddRenderer(renderer)
    renderer.AddActor(actor)
    renderer.ResetCamera()
    u3d_exporter = vtku3dexporter.vtkU3DExporter()
    file_path = os.path.join(destination_folder, filename)
    #u3d_exporter.SetFileName(file_path)
    u3d_exporter.SetInput(render_window)
    print("writing file to {}.u3d".format(file_path))
    u3d_exporter.Write()
    print("testing that file exists...")
    # Check that we have successfully created a U3D file
    if not os.path.exists("{}.u3d".format(file_path)):  # The extension get's added by the Exporter itself
        raise Exception("Failed to create the U3D file")
    print("test completed")


# Create cube
cube = vtk.vtkCubeSource()

# Mapper
cubeMapper = vtk.vtkPolyDataMapper()
cubeMapper.SetInputData(cube.GetOutput())

# Actor
cubeActor = vtk.vtkActor()
cubeActor.SetMapper(cubeMapper)

# Write u3d
dir_path = tempfile.gettempdir()
os.chdir(dir_path)
write_u3d(dir_path, "test_report", cubeActor)
