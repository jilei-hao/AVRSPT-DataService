from sys import argv
from vtkmodules.vtkIOImage import vtkNIFTIImageReader
from vtkmodules.vtkIOXML import vtkXMLImageDataWriter


def main():
    args = argv[1:]
    fnIn, fnOut = args

    reader = vtkNIFTIImageReader()
    reader.SetFileName(fnIn)
    reader.Update()

    img = reader.GetOutput()
    print(img)
    
    writer = vtkXMLImageDataWriter()
    writer.SetInputData(reader.GetOutput())
    writer.SetFileName(fnOut)
    writer.Write()


if __name__ == "__main__":
    main()
