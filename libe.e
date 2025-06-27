

func printnumber(auto Number)
{
    if (!Number)
    {
        write(1, "0", 1);
    }
    else
    {
        auto NumberText = itoa(Number);
        auto NumberTextLen = strlen(NumberText);
        write(1, NumberText, NumberTextLen);
    }
}

func print(char msg[], auto msg_len, auto i, auto Number, auto IfPrintNumber)
{
    if (IfPrintNumber & msg[i] == '%' & i + 1 < msg_len & msg[i + 1] == 'd')
    {
        printnumber(Number);
        return 2;
    }
    if (IfPrintNumber & msg[i] == '%' & i + 1 < msg_len & msg[i + 1] == 'c')
    {
        char c[1];
        c[0] = Number;
        write(1, c, 1);
        return 2;
    }
    if (IfPrintNumber & msg[i] == '%' & i + 1 < msg_len & msg[i + 1] == 's')
    {
        auto NumberTextLen = strlen(Number);
        write(1, Number, NumberTextLen);
        return 2;
    }
    if (IfPrintNumber & msg[i] == '%' & i + 1 < msg_len & msg[i + 1] == 'l' & i + 2 < msg_len & msg[i + 2] == 'd')
    {
        printnumber(Number);
        return 3;
    }
    write(1, msg + i, 1);
    return 1;
}

func print1(char msg[])
{
    auto msg_len = strlen(msg);
    auto i = 0;
    while (i < msg_len)
    {
        write(1, msg + i, 1);
        i = i + 1;
    }
}

func print2(char msg[], auto a)
{
    auto msg_len = strlen(msg);
    auto i = 0;
    auto n = 0;
    while (i < msg_len)
    {
        if (n == 0)
        {
            
            auto skip = print(msg, msg_len, i, a, 1);
            i = i + skip;
            if (skip != 1)
                n = n + 1;
        }
        else
        {
            auto skip = print(msg, msg_len, i, 0, 0);
            i = i + skip;
        }
    }
}

func print3(char msg[], auto a, auto b)
{
    auto msg_len = strlen(msg);
    auto i = 0;
    auto n = 0;
    while (i < msg_len)
    {
        if (n == 0)
        {
            auto skip = print(msg, msg_len, i, a, 1);
            i = i + skip;
            if (skip != 1)
                n = n + 1;
        }
        else if (n == 1)
        {
            auto skip = print(msg, msg_len, i, b, 1);
            i = i + skip;
            if (skip != 1)
                n = n + 1;
        }
        else
        {
            auto skip = print(msg, msg_len, i, 0, 0);
            i = i + skip;
        }
    }
}