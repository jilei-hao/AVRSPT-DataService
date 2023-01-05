from sys import argv
from ReadPolyData import ReadPolyData
from vtkmodules.vtkFiltersCore import vtkDecimatePro
from vtkmodules.vtkIOXML import vtkXMLPolyDataWriter

def main():
    args = argv[1:]
    fn, factor, fnout = args

    polyData = ReadPolyData(fn)

    decimator = vtkDecimatePro()
    decimator.SetInputData(polyData)
    decimator.PreserveTopologyOn()
    decimator.SetTargetReduction(float(factor))
    decimator.Update()

    decimatedData = decimator.GetOutput()

    writer = vtkXMLPolyDataWriter()
    writer.SetInputData(decimatedData)
    writer.SetFileName(fnout)
    writer.Write()


if __name__ == "__main__":
    main()
