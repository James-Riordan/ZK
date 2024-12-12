// Lightweight (custom) wrapper for init & deinit of SqliteDB

const sqlite = @import("sqlite");
const std = @import("std");

pub fn init(allocator: std.mem.Allocator) anyerror!sqlite.Db {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const db = try sqlite.Db.init(.{
        .mode = sqlite.Db.Mode{ .File = "./zk.db" },
        .open_flags = .{
            .write = true,
            .create = true,
        },
        .threading_mode = .MultiThread,
    });
    return db;
}

// Define the deinit function for sqlite.Db
pub fn deinit(db: *sqlite.Db) void {
    db.deinit(); // Ensure the database is properly closed
}
