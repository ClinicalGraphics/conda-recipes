import vtk

sphere_source = vtk.vtkArrowSource()

mapper = vtk.vtkPolyDataMapper()
mapper.SetInputData(sphere_source.GetOutput())

actor = vtk.vtkActor()
actor.SetMapper(mapper)

renderer = vtk.vtkRenderer()
renderer.AddActor(actor)
renderer.SetBackground(.1, .2, .3)

render_window = vtk.vtkRenderWindow()
render_window.SetOffScreenRendering(True)
render_window.AddRenderer(renderer)
render_window.Render()

window_to_image_filter = vtk.vtkWindowToImageFilter()
window_to_image_filter.SetInput(render_window)
window_to_image_filter.Update()

writer = vtk.vtkPNGWriter()
writer.SetFileName("render.png")
writer.SetInputData(window_to_image_filter.GetOutput())
writer.Write()