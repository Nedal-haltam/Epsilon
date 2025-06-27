func print(char msg[])
{
    auto msg_len = strlen(msg);
    auto i = 0;
    while (i < msg_len)
    {
        if (msg[i] == '%' & i + 1 < msg_len & msg[i + 1] == 'd')
        {
            // print a number
            i = i + 2;
        }
        else
        {
            write(1, msg + i, 1);
            i = i + 1;
        }
    }
}

func println(auto msg[])
{
    print(msg);
    print("\n");
}
