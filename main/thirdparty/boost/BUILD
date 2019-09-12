cc_library(
    name = "cppnetlib",
    hdrs = glob([
        "*.hpp",
        "network/**/*.hpp",
        ]),
    srcs = glob(["libs/**/*.cpp"]), 
    deps = ["@boost//:asio"],
    visibility = ["//visibility:public"],
)
