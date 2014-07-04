We want to parse a file like the following

    include "main.conf";
    variable1 = "whatever";
    smtp {
        port 25;
        host "smtp.example.com";
        username "foo";
        sender "bar";
        recipients [
            "user1@example.com",
            "user2@example.com",
        ];
    }

    crypto {
        password "r34ls3cr3t";
        url [
            "http://192.168.1.23:8080/endpoint",
        ];
    }

    path {
        in  "${HOME}/IN"
        out "${HOME}/OUT"
    }
