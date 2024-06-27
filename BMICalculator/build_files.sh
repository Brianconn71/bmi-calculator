echo "Building the project..."
pip install -r requirements.txt
echo "No static shit"
python3 manage.py collectstatic --noinput