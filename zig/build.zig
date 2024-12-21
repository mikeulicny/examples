const std = @import("std");
const Build = std.Build;
const OptimizeMode = std.builtin.OptimizeMode;

pub fn build(b: *Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const dep_sokol = b.dependency("sokol", .{
        .target = target,
        .optimize = optimize,
    });
   const clear = b.addExecutable(.{
        .name = "clear",
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/clear.zig"),
    });
    clear.root_module.addImport("sokol", dep_sokol.module("sokol"));
    b.installArtifact(clear);
    const run = b.addRunArtifact(clear);
    b.step("run", "Run hello").dependOn(&run.step);
}
