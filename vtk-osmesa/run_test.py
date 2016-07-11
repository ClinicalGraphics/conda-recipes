""" VTK to screenshot python example """
import vtk
from vtk.util import numpy_support

# create a rendering window and renderer
ren = vtk.vtkRenderer()
render_window = vtk.vtkRenderWindow()
render_window.AddRenderer(ren)

# create source
source = vtk.vtkSphereSource()
source.SetCenter(0,0,0)
source.SetRadius(2.0)
source.Update()

# mapper
mapper = vtk.vtkPolyDataMapper()
mapper.SetInputData(source.GetOutput())

# actor
actor = vtk.vtkActor()
actor.SetMapper(mapper)

# color the actor
actor.GetProperty().SetColor(1,0,0) # (R,G,B)

# assign actor to the renderer
ren.AddActor(actor)
ren.SetBackground(1, 1, 1)

# render internally
render_window.Render()

# screenshot code:
w2if = vtk.vtkWindowToImageFilter()
w2if.SetInput(render_window)
w2if.Update()
image_data = w2if.GetOutput()

# write to png
writer = vtk.vtkPNGWriter()
writer.SetFileName("screenshot.png")
writer.SetInputData(image_data)
writer.Write()

# read image:
reader = vtk.vtkPNGReader()
reader.SetFileName("screenshot.png")
reader.Update()
screenshot_data = reader.GetOutput()

# compare vtkimagedata from Filter to vtkimagedata from reader
reader.Update()
screenshot_data = reader.GetOutput()

np_array_1 = numpy_support.vtk_to_numpy(image_data.GetPointData().GetArray(0))
np_array_2 = numpy_support.vtk_to_numpy(screenshot_data.GetPointData().GetArray(0))
assert (np_array_1 == np_array_2).all()
