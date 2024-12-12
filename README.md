# Zig Kontent (zk)

Zig Kontent (zk) is a lightweight, high-performance CLI tool designed to manage and curate a wide variety of content types. Whether you're organizing books, podcasts, movies, video games, or academic papers, zk provides a unified and extensible interface for creating, updating, and querying your personalized database of content.

## Features

- **CRUD Operations:** Add, edit, delete, and retrieve content effortlessly.
- **Multi-Type Support:** Manage diverse content types, including:
  - Books
  - Podcasts
  - Movies/Shows
  - Video Games
  - Songs
  - Papers (Research or Whitepapers)
  - Videos
  - Articles/Blogs
  - Miscellaneous
- **Optional Metadata:**
  - Status tracking (e.g., to do, read, watched, etc.).
  - Ratings and genres.
  - Prerequisites for logical content progression.
- **Custom Queries:** Advanced filtering options for tailored searches.
- **SQLite Backend:** Robust and lightweight database engine.
- **Unified CLI Interface:** Simple commands for all operations with performance-focused design.

## Installation

### Prerequisites
- Zig Compiler
- SQLite (embedded with Zig, no external dependency needed)

### Clone and Build

```bash
# Clone the repository
git clone https://github.com/yourusername/zk.git
cd zk

# Build the project
zig build
```
```
# Add zk to your PATH for easy access

# macos:
export PATH="$PWD/zig-out/bin:$PATH"

# windows:
export PATH="$PWD/zig-out/bin:$PATH"

# linux: 
export PATH="$PWD/zig-out/bin:$PATH"
```

### Usage

Run the CLI tool using:
```bash
zk [command] [options]
```

## Commands

### General

## General

| Command     | Description                               |
| ----------- | ----------------------------------------- |
| `zk create` | Add a new content entry.                  |
| `zk update` | Update an existing entry.                 |
| `zk delete` | Remove an entry from the database.        |
| `zk list`   | Display content based on filters.         |
| `zk export` | Export data to a file for backup/sharing. |
| `zk import` | Import data from a file.                  |

## Options

| Option           | Description                                 |
| ---------------- | ------------------------------------------- |
| `-t`, `--type`   | Specify content type (e.g., book, podcast). |
| `-n`, `--name`   | Specify content name/title.                 |
| `-s`, `--status` | Specify status (e.g., to do, watched).      |
| `-d`, `--date`   | Specify publication or release date.        |
| `-r`, `--rating` | Specify a rating for the content.           |

## Examples

**1. Add a book:**

```bash
zk create -t book -n "The Cycle of Cosmic Catastrophes" -s "to do" -d 2006 -r 5
```

**2. List all podcasts with the `to do` status:**

```bash
zk create -t book -n "The Cycle of Cosmic Catastrophes" -s "to do" -d 2006 -r 5
```

**3. Update the status of a video game:**

```bash
zk update -t videogame -n "Hollow Knight" -s "played"
```

**4. Export your curated database:**

```bash
zk export --file my_content.json
```

## Project Structure

```bash
zk/
├── build.zig
├── src/
│   ├── main.zig
│   ├── cli/
│   │   ├── parser.zig
│   │   ├── commands.zig
│   │   ├── helpers.zig
│   ├── db/
│   │   ├── init.zig
│   │   ├── migrations.zig
│   │   ├── queries.zig
│   │   ├── tables/
│   │   │   ├── books.zig
│   │   │   ├── podcasts.zig
│   │   │   ├── movies_shows.zig
│   │   │   ├── video_games.zig
│   │   │   ├── songs.zig
│   │   │   ├── papers.zig
│   │   │   ├── videos.zig
│   │   │   ├── articles.zig
│   │   │   └── misc.zig
│   ├── models/
│   │   ├── content_types.zig
│   │   ├── status.zig
│   ├── services/
│   │   ├── content.zig
│   │   ├── filters.zig
│   │   └── export.zig
│   ├── utils/
│   │   ├── logger.zig
│   │   ├── validation.zig
│   │   ├── format.zig
│   └── config.zig
├── tests/
│   ├── cli_tests.zig
│   ├── db_tests.zig
│   ├── services_tests.zig
├── README.md
├── LICENSE
```

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

### Development

1. Fork the repository

2. Create a feature branch: `git checkout -b feature/my-feature`

3. Commit changes: `git commit -m "Add my feature"`

4. Push to the branch: `git push origin feature/my-feature`

5. Open a pull request

## License

This project is licensed under the MIT License. See the LICENSE file for details.