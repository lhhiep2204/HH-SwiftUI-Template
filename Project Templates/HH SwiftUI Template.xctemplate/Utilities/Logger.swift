//___FILEHEADER___

import Foundation

enum LogLevel: String {
    case info = "🔵"
    case warning = "🟠"
    case error = "🔴"
}

#if DEBUG
final class Logger {
    private static func logHeader(_ level: LogLevel,
                                  file: String,
                                  line: Int,
                                  column: Int,
                                  function: String) {
        print("\(level.rawValue) \(getFileName(file)): Line \(line), Column: \(column) ~ \(function)")
    }

    private static func getFileName(_ file: String) -> String {
        let fileURL = URL(filePath: file)
        return fileURL.lastPathComponent
    }
}

extension Logger {
    static func info(file: String = #file,
                     line: Int = #line,
                     column: Int = #column,
                     function: String = #function,
                     _ messages: Any...) {
        logHeader(.info, file: file, line: line, column: column, function: function)

        for message in messages {
            print("\(message)\n")
        }
    }

    static func warning(file: String = #file,
                        line: Int = #line,
                        column: Int = #column,
                        function: String = #function,
                        _ messages: Any...) {
        logHeader(.warning, file: file, line: line, column: column, function: function)

        for message in messages {
            print("\(message)\n")
        }
    }

    static func error(file: String = #file,
                      line: Int = #line,
                      column: Int = #column,
                      function: String = #function,
                      _ messages: Any...) {
        logHeader(.error, file: file, line: line, column: column, function: function)

        for message in messages {
            print("\(message)\n")
        }
    }
}
#endif
