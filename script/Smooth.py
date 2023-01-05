from sys import argv
from ReadPolyData import ReadPolyData
from vtkmodules.vtkFiltersCore import vtkWindowedSincPolyDataFilter
from vtkmodules.vtkIOXML import vtkXMLPolyDataWriter

def main():
    args = argv[1:]
    fn, pb, nit, fnout = args

    polyData = ReadPolyData(fn)

    smoother = vtkWindowedSincPolyDataFilter()
    smoother.SetInputData(polyData)
    smoother.SetPassBand(float(pb))
    smoother.SetNumberOfIterations(int(nit))
    smoother.Update()

    smoothedData = smoother.GetOutput()

    writer = vtkXMLPolyDataWriter()
    writer.SetInputData(smoothedData)
    writer.SetFileName(fnout)
    writer.Write()


if __name__ == "__main__":
    main()
