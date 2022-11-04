from ReadPolyData import ReadPolyData
from sys import argv
from vtkmodules.vtkCommonCore import vtkStringArray
from vtkmodules.vtkCommonCore import vtkDoubleArray
from vtkmodules.vtkIOXML import vtkXMLPolyDataWriter


def main():
    args = argv[1:]
    fn, name, value, fnout = args

    polyData = ReadPolyData(fn)
    tpData = vtkDoubleArray()
    tpData.SetNumberOfValues(1)
    tpData.SetName(name)
    tpData.SetValue(0, float(value))
    polyData.GetFieldData().AddArray(tpData)

    writer = vtkXMLPolyDataWriter()
    writer.SetInputData(polyData)
    writer.SetFileName(fnout)
    writer.Write()


if __name__ == "__main__":
    main()
