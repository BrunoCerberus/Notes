# Notes
I developed a simple Notes SwiftUI app conected with a local Node.js gRPC Microservice which is inside the root's project (`node-grpc-server-note-crud`), to use it,
you must install NVM and used Node.js 10 (`nvm use 10`), after that, enter the folder `node-grpc-server-note-crud` and type `npm install`, 
when finishes, type `npm start` to execute the gRPC microservice. The is already configured to connect with this local microservice.

To install the project dependencies, use cocoapods `1.10.1` or later, then enter on the root's project and type `pod install`.

## Requirements for running this project
- Xcode 12.4
- iOS 14+
- Swift 5.3.2
- Cocoapods 1.10.1 or later

## Dependencies used
- gRPC Swift https://github.com/grpc/grpc-swift

## Plugins used
- Apple Swift Protobuf https://github.com/apple/swift-protobuf

## gRPC Microservice used (already inside root project)
- https://github.com/alfianlosari/node-grpc-server-note-crud

## Author

| [<img src="https://avatars3.githubusercontent.com/u/10541956?s=400&u=eba6b61af608c7dbc1d36cbf2abacb880d9c6a71&v=4" width="48"><br><sub>@BrunoCerberus</sub>](https://github.com/BrunoCerberus) |
| :---: |

## License

All the code available under the MIT license. See [LICENSE](LICENSE).

```
MIT License

Copyright (c) 2021 Bruno Lopes de Mello

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
