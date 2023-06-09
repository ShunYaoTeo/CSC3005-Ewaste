@echo off
setlocal

:: Set your base path here, or pass as a command line argument
set BASE_PATH=%~1
if "%BASE_PATH%"=="" (
    echo Base path not set. Please pass the base path as a command line argument.
    exit /b 1
)

:: Apply DB manifests in order
call :applyManifests "%BASE_PATH%\auth_manifests\auth_db_manifests" db-auth-configmap.yaml
call :applyManifests "%BASE_PATH%\auth_manifests\auth_db_manifests" db-auth-pvc.yaml
call :applyManifests "%BASE_PATH%\auth_manifests\auth_db_manifests" db-secrets.yaml
call :applyManifests "%BASE_PATH%\auth_manifests\auth_db_manifests" db-auth-deploy.yaml
call :applyManifests "%BASE_PATH%\auth_manifests\auth_db_manifests" db-auth-service.yaml

call :applyManifests "%BASE_PATH%\ewaste_manifests\ewaste_db_manifests" db-ewaste-configmap.yaml
call :applyManifests "%BASE_PATH%\ewaste_manifests\ewaste_db_manifests" db-ewaste-pvc.yaml
call :applyManifests "%BASE_PATH%\ewaste_manifests\ewaste_db_manifests" db-secrets.yaml
call :applyManifests "%BASE_PATH%\ewaste_manifests\ewaste_db_manifests" db-ewaste-deploy.yaml
call :applyManifests "%BASE_PATH%\ewaste_manifests\ewaste_db_manifests" db-ewaste-service.yaml

call :applyManifests "%BASE_PATH%\rewards_manifests\rewards_db_manifests" db-rewards-configmap.yaml
call :applyManifests "%BASE_PATH%\rewards_manifests\rewards_db_manifests" db-rewards-pvc.yaml
call :applyManifests "%BASE_PATH%\rewards_manifests\rewards_db_manifests" db-secrets.yaml
call :applyManifests "%BASE_PATH%\rewards_manifests\rewards_db_manifests" db-rewards-deploy.yaml
call :applyManifests "%BASE_PATH%\rewards_manifests\rewards_db_manifests" db-rewards-service.yaml

:: Apply service manifests
call :applyManifests "%BASE_PATH%\gateway_manifests" *.yaml
call :applyManifests "%BASE_PATH%\auth_manifests" *.yaml
call :applyManifests "%BASE_PATH%\ewaste_manifests" *.yaml
call :applyManifests "%BASE_PATH%\rewards_manifests" *.yaml

:: Function to apply manifests
:applyManifests
echo Searching in: %~1 for %~2
for /R "%~1" %%f in (%~2) do (
    if exist "%%f" (
        echo Applying: %%f
        kubectl apply -f "%%f"
    ) else (
        echo No match: %%f
    )
)
goto :eof

exit /b 0
