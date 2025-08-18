# Mastermind API - LinkedIn Backend Apprentice Challenge

A Ruby on Rails API backend for the Mastermind game challenge. This API provides authentication, game management, and game logic for a web-based Mastermind game where players try to guess a 4-digit code within 10 attempts.

## 🎯 Challenge Overview

This project implements the Mastermind game as specified in the LinkedIn Backend Apprentice challenge:

- **Game Rules**: Players have 10 attempts to guess a 4-digit code (digits 0-7)
- **Feedback System**: After each guess, players receive feedback on correct numbers and correct positions
- **User Interface**: Web-based interface with game history and remaining attempts display

## 🏗️ Architecture & Thought Process

### Design Decisions

1. **Rails API Mode**: Chose Rails API mode for a lightweight, focused backend that serves JSON responses
2. **JWT Authentication**: Implemented JWT tokens for stateless authentication, allowing for scalable session management
3. **Service Layer Pattern**: Separated business logic into service classes (AuthService, GameService, GuestGameService) for better testability and maintainability
4. **ResponseEntity Wrapper**: Created a consistent response format across all endpoints for better API documentation and client integration
5. **Guest Game Support**: Implemented session-based guest games using Rails cache for users who don't want to register

### Code Structure

```
app/
├── controllers/
│   ├── api/v1/
│   │   ├── auth_controller.rb          # User authentication
│   │   ├── games_controller.rb         # Authenticated game management
│   │   ├── guest_games_controller.rb   # Guest game management
│   │   └── guesses_controller.rb       # Guess submission
├── models/
│   ├── user.rb                         # User model with bcrypt
│   ├── game.rb                         # Game model with validations
│   └── guess.rb                        # Guess model with feedback logic
├── services/
│   ├── auth_service.rb                 # Authentication business logic
│   ├── game_service.rb                 # Game management logic
│   ├── guest_game_service.rb           # Guest game logic
│   └── jwt_service.rb                  # JWT token handling
└── contracts/
    └── response_entity.rb              # Standardized API response wrapper
```

## 🚀 Features

### Core Features (Challenge Requirements)

- ✅ 4-digit code generation (digits 0-7)
- ✅ 10 attempts maximum
- ✅ Feedback system (correct numbers/positions)
- ✅ Web-based interface
- ✅ Game history display
- ✅ Remaining attempts counter

### Creative Extensions Implemented

1. **Dual Authentication System**

   - JWT-based authentication for registered users
   - Session-based guest games for anonymous users
   - Seamless transition between guest and registered play

2. **Comprehensive API Documentation**

   - RSwag integration for automatic Swagger/OpenAPI documentation
   - Interactive API testing interface at `/api-docs`
   - Complete endpoint documentation with examples

3. **Advanced Error Handling**

   - Custom error classes for different scenarios
   - Global error handler for consistent error responses
   - Detailed error messages for debugging

4. **Robust Testing Suite**

   - RSpec request specs with RSwag for API testing
   - Comprehensive test coverage for all endpoints
   - Tests that double as API documentation

5. **Docker Support**

   - Complete containerization with Docker Compose
   - PostgreSQL database container
   - Easy deployment and development setup

6. **Enhanced Game Features**
   - Game status tracking (in_progress, win, loss)
   - Automatic win/loss detection
   - Detailed guess history with feedback

## 📋 Prerequisites

Before running this application, ensure you have the following installed:

- **Docker** (recommended) - Version 20.10 or higher
- **Docker Compose** - Version 2.0 or higher
- **Git** - For cloning the repository

**Alternative (Local Development):**

- **Ruby** - Version 3.2.2 or higher
- **PostgreSQL** - Version 12 or higher
- **Node.js** - Version 16 or higher (for asset compilation)
- **Bundler** - Ruby gem manager

## 🛠️ Installation & Setup

### Option 1: Docker (Recommended)

This is the easiest way to get started and ensures consistent environment across different machines.

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd mastermind-api
   ```

2. **Start the application**

   ```bash
   docker-compose up --build
   ```

3. **Verify the setup**
   - API will be available at: `http://localhost:3000`
   - API documentation at: `http://localhost:3000/api-docs`
   - Database will be automatically created and migrated

### Option 2: Local Development

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd mastermind-api
   ```

2. **Install Ruby dependencies**

   ```bash
   bundle install
   ```

3. **Setup PostgreSQL database**

   ```bash
   # Create database
   rails db:create

   # Run migrations
   rails db:migrate

   # (Optional) Seed with sample data
   rails db:seed
   ```

4. **Start the server**
   ```bash
   rails server
   ```

## 🎮 How to Play

### Using the API Documentation

1. **Open the API documentation**

   - Navigate to `http://localhost:3000/api-docs`
   - You'll see an interactive Swagger UI

2. **Create a guest game**

   - Find the `POST /api/v1/guest_games/create` endpoint
   - Click "Try it out" and then "Execute"
   - Copy the session ID from the response

3. **Make a guess**

   - Find the `POST /api/v1/guest_games/guess/{session_id}` endpoint
   - Replace `{session_id}` with your session ID
   - Enter a 4-digit guess (e.g., `{"guess": {"value": "1234"}}`)
   - Click "Execute"

4. **Continue guessing**
   - Use the feedback to make better guesses
   - You have 10 attempts total
   - The game ends when you guess correctly or run out of attempts

### Using a REST Client (Postman, curl, etc.)

1. **Create a guest game**

   ```bash
   curl -X POST http://localhost:3000/api/v1/guest_games/create
   ```

2. **Make a guess**
   ```bash
   curl -X POST http://localhost:3000/api/v1/guest_games/guess/YOUR_SESSION_ID \
     -H "Content-Type: application/json" \
     -d '{"guess": {"value": "1234"}}'
   ```

### Using the Frontend Client

If you have the React frontend running:

1. **Start the frontend** (in a separate terminal)

   ```bash
   cd ../mastermind-client
   npm install
   npm run dev
   ```

2. **Play the game**
   - Open `http://localhost:5173` in your browser
   - The frontend will automatically connect to the API
   - Use the web interface to play the game

## 🧪 Testing

### Running Tests

```bash
# Using Docker
docker-compose exec web bundle exec rspec

# Local development
bundle exec rspec
```

### Test Coverage

- **Request Specs**: All API endpoints are tested with RSwag
- **Model Specs**: Database models and validations
- **Service Specs**: Business logic in service classes

### Generating API Documentation

```bash
# Generate Swagger documentation from tests
docker-compose exec web bundle exec rake rswag:specs:swaggerize

# View updated documentation
open http://localhost:3000/api-docs
```

## 📊 API Endpoints

### Authentication

- `POST /api/v1/auth/register` - Register a new user
- `POST /api/v1/auth/login` - Login with credentials
- `GET /api/v1/auth/is_logged_in` - Check authentication status

### Guest Games (No Authentication Required)

- `POST /api/v1/guest_games/create` - Create a new guest game
- `GET /api/v1/guest_games/find/{session_id}` - Get game details
- `POST /api/v1/guest_games/guess/{session_id}` - Submit a guess

### Authenticated Games

- `POST /api/v1/games/create` - Create a new game (requires JWT)
- `GET /api/v1/games/{user_id}` - Get user's games (requires JWT)
- `POST /api/v1/guesses/create` - Submit a guess (requires JWT)

## 🔧 Configuration

### Environment Variables

The application uses the following environment variables:

```bash
# Database
DB_NAME=mastermind_api
DB_USER=postgres
DB_PASSWORD=password
DB_HOST=localhost

# JWT
JWT_SECRET=your-secret-key-here
JWT_ISSUER=http://localhost:3000
JWT_AUDIENCE=mastermind-api

# Rails
RAILS_ENV=development
```

### Database Configuration

The application uses PostgreSQL. Configuration is in `config/database.yml`.

## 🚀 Deployment

### Docker Deployment

```bash
# Build and run
docker-compose up --build -d

# View logs
docker-compose logs -f web

# Stop services
docker-compose down
```

### Production Deployment

1. Set `RAILS_ENV=production`
2. Configure production database
3. Set secure JWT secret
4. Enable SSL/TLS
5. Configure reverse proxy (nginx, etc.)

## 🔒 Security Features

- **Password Security**: bcrypt hashing for all passwords
- **JWT Authentication**: Secure token-based authentication
- **CORS Protection**: Configured for cross-origin requests
- **Input Validation**: Comprehensive parameter validation
- **SQL Injection Protection**: Active Record ORM protection
- **Rate Limiting**: Ready for implementation

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 Development Notes

### Key Design Patterns Used

1. **Service Layer Pattern**: Business logic separated from controllers
2. **Repository Pattern**: Data access abstraction through models
3. **Factory Pattern**: Object creation for games and users
4. **Strategy Pattern**: Different authentication strategies (JWT vs Session)

### Performance Considerations

- Database indexes on frequently queried fields
- Caching for guest game sessions
- Efficient JWT token validation
- Optimized database queries with includes

### Future Enhancements

- Rate limiting for API endpoints
- Redis caching for better performance
- WebSocket support for real-time game updates
- Multiplayer game support
- Game statistics and leaderboards

## 📄 License

This project is part of the LinkedIn Backend Apprentice challenge.

## 🆘 Troubleshooting

### Common Issues

1. **Database connection errors**

   - Ensure PostgreSQL is running
   - Check database configuration in `config/database.yml`

2. **JWT token errors**

   - Verify JWT_SECRET is set
   - Check token expiration

3. **CORS errors**
   - Ensure frontend URL is in CORS configuration
   - Check browser console for specific errors

### Getting Help

- Check the API documentation at `/api-docs`
- Review the test suite for usage examples
- Check Docker logs: `docker-compose logs web`

---

**Built with ❤️ for the LinkedIn Backend Apprentice Challenge**
