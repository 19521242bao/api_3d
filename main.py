from fastapi import FastAPI, Request, UploadFile, File
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from fastapi.staticfiles import StaticFiles
import uvicorn
from typing import List
import os
 
IMAGEDIR = "images/"
 
app = FastAPI()
templates = Jinja2Templates(directory="templates")
app.mount("/images", StaticFiles(directory="images"), name="images")
 
@app.get('/', response_class=HTMLResponse)
def home(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})
 
@app.post("/upload-files")
async def create_upload_files(request: Request, files: List[UploadFile] = File(...)):
    for file in files:
        contents = await file.read()
        #save the file
        with open(f"{IMAGEDIR}{file.filename}", "wb") as f:
            f.write(contents)
 
    show = [file.filename for file in files]
 
    #return {"Result": "OK", "filenames": [file.filename for file in files]}
    return templates.TemplateResponse("index.html", {"request": request, "show": show})
@app.post("/reconstruction")
async def reconstruction(folder_path="images"):
    #run reconstruction.sh
    os.system("bash reconstruction.sh")
    return {"Result": "OK", "ply_path": "images/reconstruction.ply"}
    return {"Result": "OK", "ply_path": "utput/point_cloud.ply"}
if __name__ == '__main__':
    uvicorn.run(app, host='127.0.0.1', port=5040)
    print("running")

#convert string dict to dict
# import ast
# dict_str = "{'key1': 'value1', 'key2': 'value2'}"
# dict_object = ast.literal_eval(dict_str)