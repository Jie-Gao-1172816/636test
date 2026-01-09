"""Implements simple MySQL database connectivity for a Flask web app.
"""
from flask import Flask, g
from mysql.connector.pooling import MySQLConnectionPool

# Pool of reusable database connections (created when calling `init_db`).
connection_pool: MySQLConnectionPool


def init_db(app: Flask, user: str, password: str, host: str, database: str,
            port: int = 3306, pool_name: str = "flask_db_pool",
            autocommit: bool = True):
    """Sets up a MySQL connection pool for the specified Flask app"""
    # Create a pool of reusable database connections.
    global connection_pool
    connection_pool = MySQLConnectionPool(
        user=user,
        password=password,
        host=host,
        database=database,
        port=port,
        pool_name=pool_name,
        autocommit=autocommit)

    # Register `close_db()` to run every time the application context is torn
    # down at the end of a Flask request, ensuring that any database connection
    # using during that request gets released back into the pool.
    app.teardown_appcontext(close_db)


def get_db():
    """Gets a MySQL database connection to use while serving the current Flask
    request."""
    if 'db' not in g:
        g.db = connection_pool.get_connection()
    
    return g.db


def get_cursor():
    """Gets a new MySQL dictionary cursor to use while serving the current
    Flask request."""
    return get_db().cursor(dictionary=True)


def close_db(exception = None):
    """Closes the MySQL database connection associated with the current Flask
    request (if any)."""
    # Get the database connection from the current application context (the one
    # that's being torn down), or `None` if there is no connection.
    db = g.pop('db', None)
    
    if db is not None:
        db.close()