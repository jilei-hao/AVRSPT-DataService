from pathlib import Path
import sys

from vtkmodules.vtkIOGeometry import (
    vtkBYUReader,
    vtkOBJReader,
    vtkSTLReader
)
from vtkmodules.vtkIOLegacy import vtkPolyDataReader
from vtkmodules.vtkIOPLY import vtkPLYReader
from vtkmodules.vtkIOXML import (
    vtkXMLPolyDataReader,
    vtkXMLPolyDataWriter
)


def ReadPolyData(file_name):
    valid_suffixes = ['.g', '.obj', '.stl', '.ply', '.vtk', '.vtp']
    path = Path(file_name)
    if path.suffix:
        ext = path.suffix.lower()
    if path.suffix not in valid_suffixes:
        print(f'No reader for this file suffix: {ext}')
        return None
    else:
        if ext == ".ply":
            reader = vtkPLYReader()
            reader.SetFileName(file_name)
            reader.Update()
            poly_data = reader.GetOutput()
        elif ext == ".vtp":
            reader = vtkXMLPolyDataReader()
            reader.SetFileName(file_name)
            reader.Update()
            poly_data = reader.GetOutput()
        elif ext == ".obj":
            reader = vtkOBJReader()
            reader.SetFileName(file_name)
            reader.Update()
            poly_data = reader.GetOutput()
        elif ext == ".stl":
            reader = vtkSTLReader()
            reader.SetFileName(file_name)
            reader.Update()
            poly_data = reader.GetOutput()
        elif ext == ".vtk":
            reader = vtkPolyDataReader()
            reader.SetFileName(file_name)
            reader.Update()
            poly_data = reader.GetOutput()
        elif ext == ".g":
            reader = vtkBYUReader()
            reader.SetGeometryFileName(file_name)
            reader.Update()
            poly_data = reader.GetOutput()

        return poly_data


def main():
    args = sys.argv[1:]
    fnInput, fnOutput = args
    print(f'input = "{fnInput}"; output = "{fnOutput}"')
    polyData = ReadPolyData(fnInput)
    writer = vtkXMLPolyDataWriter()
    writer.SetFileName(fnOutput)
    writer.SetInputData(polyData)
    writer.Write()


if __name__ == "__main__":
    main()
