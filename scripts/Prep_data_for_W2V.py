import gensim, logging
import os
import datetime
import warnings
import optparse
import aidrtokenize;
import smart_open
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
from nltk.corpus import stopwords
stop_words = stopwords.words('english')


def processfile(inFile,outDirpath):
    base=os.path.basename(inFile)
    base=os.path.splitext(base)[0];
    outFile=outDirpath +"/"+base+"_preprocessed.txt"
    of=open(outFile,"w")            
    with smart_open.smart_open(inFile) as f:
        next(f)
        for line in f:
            #print line
            arr=line.split("\t")
            txt=""
            try:
                txt=aidrtokenize.tokenize(arr[1][1:-1])
                txt=[w for w in txt if w not in stop_words]  
                txt = " ".join(txt)
                of.write(txt+"\n")
            except Exception as e:
                print e
                continue
                pass
    of.close()
            
def processfiles(fileListFile,outDirpath):
    with smart_open.smart_open(fileListFile) as inFile:
        for fname in inFile:  
            fname=fname.strip()
            print fname
            base=os.path.basename(fname)
            base=os.path.splitext(base)[0];
            outFile=outDirpath +"/"+base+"_preprocessed.txt"
            of=open(outFile,"w")            
            with smart_open.smart_open(fname) as f:
                next(f)
                for line in f:
                    #print line
                    arr=line.split("\t")
                    txt=""
                    try:
                        txt=aidrtokenize.tokenize(arr[1][1:-1])
                        txt=[w for w in txt if w not in stop_words]  
                        txt = " ".join(txt)
                        of.write(txt+"\n")
                    except Exception as e:
                        print e
                        continue
                        pass
            of.close()
                
def process(dirname,outDirpath):
    for fname in os.listdir(dirname):  
        print fname
        #print outDirpath
        base=os.path.splitext(fname)[0];
        outFile=outDirpath +"/"+base+"_preprocessed.txt"
        of=open(outFile,"w")
        with smart_open.smart_open(os.path.join(dirname, fname)) as f:
            next(f)
            for line in f:
                #print line
                arr=line.split("\t")
                txt=""
                try:
                    txt=aidrtokenize.tokenize(arr[1][1:-1])
                    txt=[w for w in txt if w not in stop_words]  
                    txt = " ".join(txt)
                    of.write(txt+"\n")
                except Exception as e:
                    print e
                    continue
                    pass
        of.close()

if __name__ == '__main__':
    warnings.filterwarnings("ignore")
    a = datetime.datetime.now().replace(microsecond=0)
    parser = optparse.OptionParser()
    parser.add_option('-i', action="store", dest="inputFile")
    parser.add_option('-o', action="store", dest="outDir")
    options, args = parser.parse_args()
    
    inputFile=options.inputFile
    outDir=options.outDir
    outDirpath=os.path.abspath(outDir)
    print inputFile
    #process(inputDir,outDirpath)
    #processfiles(inputDir,outDirpath)
    processfile(inputFile,outDirpath)

    
