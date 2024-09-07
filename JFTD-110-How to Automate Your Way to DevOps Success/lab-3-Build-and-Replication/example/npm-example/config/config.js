require('dotenv').config();

let CONFIG = {};

CONFIG.jwt_secret_key =
    process.env.JWT_SECRET_KEY || 'f5HxCefwrdShD8P8ncPh4qFAktdnjAujASWjGxdmDVHHD4rZKWpBbjPEcDqmeP7u';
CONFIG.jwt_expiration = process.env.JWT_EXPIRATION || '1d';

// Current ENV
CONFIG.current_env = process.env.CURRENT_ENV || 'production';