const std = @import("std");
const zigada = @import("zigada.zig");

pub fn main() void {
    const url = zigada.New("https://www.GOogle.com");
    std.debug.print("Href: {}\n", .{url.Href()});

    url.SetProtocol("http:");
    url.SetHash("zigada");

    const hrefResult = try url.Href();
    const hashResult = try url.Hash();

    std.debug.print("Href: {}\n", .{hrefResult});
    std.debug.print("Hash: {}\n", .{hashResult});
}
