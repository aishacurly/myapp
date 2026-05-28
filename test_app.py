import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home_returns_200(client):
    response = client.get('/')
    assert response.status_code == 200

def test_home_returns_message(client):
    response = client.get('/')
    assert b'working' in response.data.lower() or b'hello' in response.data.lower()

def test_home_content_type(client):
    response = client.get('/')
    assert response.content_type == 'text/html; charset=utf-8'
