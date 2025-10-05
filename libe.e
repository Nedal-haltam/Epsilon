

func printnumber(auto Number, char IsSigned)
{
    if (!Number)
    {
        write(1, "0", 1);
        return 0;
    }

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

func IsSpecifier(char msg[], auto msg_len, auto i)
{
    if (msg[i] == '%' & i + 1 < msg_len)
    {
        if (msg[i + 1] == 'd')
            return 1;
        if (msg[i + 1] == 'z' & i + 2 < msg_len & msg[i + 2] == 'u')
            return 1;
        if (msg[i + 1] == 'c')
            return 1;
        if (msg[i + 1] == 's')
            return 1;
    }
}

func printhelper(char msg[], auto msg_len, auto i, auto Number)
{
    if (msg[i] == '%' & i + 1 < msg_len)
    {
        if (msg[i + 1] == 'd')
        {
            printnumber(Number, 1);
            return 2;
        }
        if (msg[i + 1] == 'z' & i + 2 < msg_len & msg[i + 2] == 'u')
        {
            printnumber(Number, 0);
            return 3;
        }
        if (msg[i + 1] == 'c')
        {
            write(1, &Number, 1);
            return 2;
        }
        if (msg[i + 1] == 's')
        {
            auto NumberTextLen = strlen(Number);
            write(1, Number, NumberTextLen);
            return 2;
        }
    }
    write(1, msg + i, 1);
    return 1;
}

func print(char msg[], ...)
{
    auto msg_len = strlen(msg);
    auto VariadicCount = __VARIADIC_COUNT__;
    if (VariadicCount == 0)
    {
        write(1, msg, msg_len);
        return 0;
    }
    auto specifiers[10];
    auto specifiers_count = 0;
    for (auto i = 0; i < msg_len; i = i + 1)
    {
        if (IsSpecifier(msg, msg_len, i))
        {
            specifiers[specifiers_count] = i;
            specifiers_count = specifiers_count + 1;
        }
    }
    if (specifiers_count == 0)
    {
        write(1, msg, msg_len);
        return 0;
    }
    auto args_count = VariadicCount;
    if (specifiers_count < args_count) args_count = specifiers_count;


    auto index = 0;
    for (auto i = 0; i < args_count; i = i + 1)
    {
        write(1, msg + index, specifiers[i] - index);
        auto specifiers_width = printhelper(msg, msg_len, specifiers[i], __VARIADIC_ARGS__(i));
        index = specifiers[i] + specifiers_width;
    }
    write(1, msg + index, msg_len - index);
}