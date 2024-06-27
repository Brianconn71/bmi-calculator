echo "Building the project..."
python3 -m pip install -r requirements.txt
echo "No static shit"
python3 manage.py collectstatic --noinput
echo "finished"