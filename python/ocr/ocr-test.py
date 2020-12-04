# -*- coding: utf-8 -*-


__author__ = 'yi_Xu'


import os


def getresults(resultFolder, imgFolder):
    """
    Parameters
    ----------
    resultFolder: results directory
    imgFolder: image directory
    """
    # Windows
    # cmd = 'cmd.exe /k tesseract.exe ' + img + 'result -l chi_sim+eng'

    # OS X
    # cmd = 'tesseract ' + img + ' result -l chi_sim'

    imgList = os.listdir(imgFolder)
    # os.chdir(imgFolder)
    for i in range(0, len(imgList)):
        resultFile = ' %s-%s' % (resultFolder, imgList[i].split('.')[0])
        print(resultFile)
        cmds = r'D:\Applications\tesseract\tesseract.exe ' + \
            os.path.join('.', os.path.join(
                'img', imgList[i])) + ' ' + resultFile + r' -l eng'  # chi_sim+
        print(cmds)
        os.popen(cmds)


if __name__ == '__main__':
    print('start……')
    getresults(r'result', r'img')
