import vtk
import os
import vtku3dexporter
import tempfile

# create cube
cube = vtk.vtkCubeSource()

# mapper
cubeMapper = vtk.vtkPolyDataMapper()
cubeMapper.SetInputData(cube.GetOutput())

# actor
cubeActor = vtk.vtkActor()
cubeActor.SetMapper(cubeMapper)


def write_u3d(destination_path, actor):
    render_window = vtk.vtkRenderWindow()
    render_window.OffScreenRenderingOn()
    renderer = vtk.vtkRenderer()
    render_window.AddRenderer(renderer)
    renderer.AddActor(actor)

    renderer.ResetCamera()
    render_window.Render()
    u3d_exporter = vtku3dexporter.vtkU3DExporter()
    u3d_file_path = os.path.join(destination_path, "report")
    u3d_exporter.SetFileName(u3d_file_path)
    u3d_exporter.SetInput(render_window)
    print(u3d_file_path)
    print("writing...")
    u3d_exporter.Write()
    print("test")
    # Check that we have successfully created a U3D file
    if not os.path.exists("{}.u3d".format(u3d_file_path)):  # The extension get's added by the Exporter itself
        raise Exception("Failed to create the U3D file")


dir_path = tempfile.gettempdir() # prints the current temporary directory

write_u3d(dir_path, cubeActor)
