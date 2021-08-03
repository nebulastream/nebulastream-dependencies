To bootstrap this project, you need to run:

```
git submodule update --init && ./vcpkg/bootstrap-vcpkg.sh -disableMetrics
```

Afterwards, you may build the dependencies for your platform, such as `build-linux-x64.sh`.

NOTE: This project is under development and still pre-alpha, you may need to trust your guts to get things done.