
func print(char msg[], ...)
{
    auto msg_len = strlen(msg);
    if (msg_len == 0) return 0;
    auto VariadicCount = __VARIADIC_COUNT__;
    if (VariadicCount == 0)
    {
        write(1, msg, msg_len);
        return 0;
    }
    // variadic args won't exceed 10
    auto specifiers[10];
    auto specifiers_count = 0;
    for (auto i = 0; i < msg_len - 1; i = i + 1)
    {
        if (msg[i] == '%')
        {
            auto msgp1 = msg[i + 1];
            if (msgp1 == 'd')
            {
                specifiers[specifiers_count] = i;
                specifiers_count = specifiers_count + 1;
            }
            elif (msgp1 == 's')
            {
                specifiers[specifiers_count] = i;
                specifiers_count = specifiers_count + 1;
            }
            elif (msgp1 == 'c')
            {
                specifiers[specifiers_count] = i;
                specifiers_count = specifiers_count + 1;
            }
            elif (msgp1 == 'z' & i + 2 < msg_len & msg[i + 2] == 'u')
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
        auto msgp1 = msg[spec + 1];
        if (msgp1 == 'd')
        {
            printnumber_signed(Number);
            index = spec + 2;
        }
        elif (msgp1 == 's')
        {
            auto NumberTextLen = strlen(Number);
            write(1, Number, NumberTextLen);
            index = spec + 2;
        }
        elif (msgp1 == 'c')
        {
            write(1, &Number, 1);
            index = spec + 2;
        }
        elif (msgp1 == 'z' & spec + 2 < msg_len & msg[spec + 2] == 'u')
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
            index = spec + 3;
        }
    }
    write(1, msg + index, msg_len - index);
}