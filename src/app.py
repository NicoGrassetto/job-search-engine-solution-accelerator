from fastapi import FastAPI, HTTPException, status

app = FastAPI(title="Job Search Engine API")


@app.get("/jobs/", tags=["jobs"])
async def list_jobs():
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="Listing jobs is not implemented yet.",
    )


@app.post("/jobs", tags=["jobs"])
async def create_job():
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="Creating jobs is not implemented yet.",
    )


@app.get("/jobs/recommendations", tags=["jobs"])
async def get_job_recommendations():
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="Job recommendations are not implemented yet.",
    )


@app.put("/jobs/{id}", tags=["jobs"])
async def update_job(id: str):
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="Updating jobs is not implemented yet.",
    )


@app.delete("/jobs/{id}", tags=["jobs"])
async def delete_job(id: str):
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="Deleting jobs is not implemented yet.",
    )


@app.get("/profiles/", tags=["profiles"])
async def list_profiles():
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="Listing profiles is not implemented yet.",
    )


@app.post("/profiles", tags=["profiles"])
async def create_profile():
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="Creating profiles is not implemented yet.",
    )


@app.get("/profiles/recommendations", tags=["profiles"])
async def get_profile_recommendations():
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="Profile recommendations are not implemented yet.",
    )


@app.put("/profiles/{id}", tags=["profiles"])
async def update_profile(id: str):
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="Updating profiles is not implemented yet.",
    )


@app.delete("/profiles/{id}", tags=["profiles"])
async def delete_profile(id: str):
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail="Deleting profiles is not implemented yet.",
    )