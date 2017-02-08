""" VTK to screenshot python example """
import vtk
import sys
from sys import platform

# Test rendering on linux only (offscreen not supported yet on windows):
if platform != "linux" or platform != "linux2":
    sys.exit(0)

# create a rendering window and renderer
ren = vtk.vtkRenderer()

# Uncheck to test with osPray
#ren.SetPass(vtk.vtkOSPRayPass())

render_window = vtk.vtkRenderWindow()
render_window.SetOffScreenRendering(True)  # This will render offscreen

render_window.AddRenderer(ren)
render_window.SetSize(3000, 3000)

# create source
source = vtk.vtkSphereSource()
source.SetCenter(0, 0, 0)
source.SetRadius(2.0)
source.Update()

# mapper
mapper = vtk.vtkPolyDataMapper()
mapper.SetInputData(source.GetOutput())

# actor
actor = vtk.vtkActor()
actor.SetMapper(mapper)

# color the actor
actor.GetProperty().SetColor(1, 0, 0)  # (R,G,B)

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
image_diff = vtk.vtkImageDifference()
image_diff.SetInputData(image_data)
image_diff.SetImageData(screenshot_data)
image_diff.Update()
error = image_diff.GetError()

print("Image from rendered screenshot differs from reference by {}".format(error))

if error > 0.01:
    raise ValueError("Didn't render correctly, build probably failed")
