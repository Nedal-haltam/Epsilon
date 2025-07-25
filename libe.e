

func printnumber(auto Number, char IsSigned)
{
    if (!Number)
    {
        write(1, "0", 1);
    }
    else
    {
        if (IsSigned)
        {
            if (Number == 1 << 63)
            {
                write(1, "-9223372036854775808", 20);
                return 0;
            }
            if (Number < 0)
            {
                Number = -Number;
                write(1, "-", 1);
            }
            auto NumberText = stoa(Number);
            auto NumberTextLen = strlen(NumberText);
            write(1, NumberText, NumberTextLen);
        }
        else
        {
            auto NumberText = unstoa(Number);
            auto NumberTextLen = strlen(NumberText);
            write(1, NumberText, NumberTextLen);
        }
    }
}

func printhelper(char msg[], auto msg_len, auto i, auto Number, auto IfPrintNumber)
{
    if (IfPrintNumber & msg[i] == '%' & i + 1 < msg_len & msg[i + 1] == 'd')
    {
        printnumber(Number, 1);
        return 2;
    }
    if (IfPrintNumber & msg[i] == '%' & i + 1 < msg_len & msg[i + 1] == 'z' & i + 2 < msg_len & msg[i + 2] == 'u')
    {
        printnumber(Number, 0);
        return 3;
    }
    if (IfPrintNumber & msg[i] == '%' & i + 1 < msg_len & msg[i + 1] == 'c')
    {
        write(1, &Number, 1);
        return 2;
    }
    if (IfPrintNumber & msg[i] == '%' & i + 1 < msg_len & msg[i + 1] == 's')
    {
        auto NumberTextLen = strlen(Number);
        write(1, Number, NumberTextLen);
        return 2;
    }
    write(1, msg + i, 1);
    return 1;
}

func print(char msg[], ...)
{
    auto msg_len = strlen(msg);
    auto i = 0;
    auto n = 0;
    auto VariadicCount = __VARIADIC_COUNT__;
    while (i < msg_len)
    {
        if (0 < VariadicCount)
        {
            auto skip = printhelper(msg, msg_len, i, __VARIADIC_ARGS__(n), 1);
            i = i + skip;
            if (skip != 1)
            {
                n = n + 1;
                VariadicCount = VariadicCount - 1;
            }
        }
        else
        {
            auto skip = printhelper(msg, msg_len, i, 0, 0);
            i = i + skip;
        }
    }
}
