

func printnumber_signed(auto Number)
{
    if (!Number)
    {
        write(1, "0", 1);
        return 0;
    }
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
        if (msg[i] == '%' & i + 1 < msg_len)
        {
            auto msgp1 = msg[i + 1];
            if (msgp1 == 'd')
            {
                specifiers[specifiers_count] = i;
                specifiers_count = specifiers_count + 1;
            }
            else if (msgp1 == 's')
            {
                specifiers[specifiers_count] = i;
                specifiers_count = specifiers_count + 1;
            }
            else if (msgp1 == 'c')
            {
                specifiers[specifiers_count] = i;
                specifiers_count = specifiers_count + 1;
            }
            else if (msgp1 == 'z' & i + 2 < msg_len & msg[i + 2] == 'u')
            {
                specifiers[specifiers_count] = i;
                specifiers_count = specifiers_count + 1;
            }
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
        auto spec = specifiers[i];

        write(1, msg + index, spec - index);

        auto Number = __VARIADIC_ARGS__(i);
        auto specifiers_width = 0;
        auto msgp1 = msg[spec + 1];
        if (msgp1 == 'd')
        {
            printnumber_signed(Number);
            specifiers_width = 2;
        }
        if (msgp1 == 's')
        {
            auto NumberTextLen = strlen(Number);
            write(1, Number, NumberTextLen);
            specifiers_width = 2;
        }
        if (msgp1 == 'c')
        {
            write(1, &Number, 1);
            specifiers_width = 2;
        }
        if (msgp1 == 'z' & spec + 2 < msg_len & msg[spec + 2] == 'u')
        {
            if (!Number)
            {
                write(1, "0", 1);
            }
            else
            {
                auto NumberText = unstoa(Number);
                auto NumberTextLen = strlen(NumberText);
                write(1, NumberText, NumberTextLen);
            }
            specifiers_width = 3;
        }

        index = spec + specifiers_width;
    }
    write(1, msg + index, msg_len - index);
}