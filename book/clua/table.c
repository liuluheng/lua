#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

void error(lua_State * L, const char *fmt, ...)
{
    va_list argp;
    va_start(argp, fmt);
    vfprintf(stderr, fmt, argp);
    va_end(argp);
    lua_close(L);
    exit(EXIT_FAILURE);
}

#define MAX_COLOR 255
/* assume that table is on the stack top */
int getcolorfield (lua_State *L, const char *key) {
    int result;
    lua_pushstring(L, key); /* push key */
    lua_gettable(L, -2); /* get background[key] */
    if (!lua_isnumber(L, -1))
        error(L, "invalid component in background color");
    result = (int)(lua_tonumber(L, -1) * MAX_COLOR);
    lua_pop(L, 1); /* remove number */
    return result;
}


int main(void)
{
    lua_State *L = luaL_newstate();     /* opens Lua */
    //luaL_openlibs(L);           /* opens the standard libraries */

    if (luaL_loadfile(L, "color.lua") || lua_pcall(L, 0, 0, 0))
        error(L, "cannot run config. file: %s", lua_tostring(L, -1));

    lua_getglobal(L, "background");
    if (!lua_istable(L, -1))
        error(L, "'background' is not a table");
    int red = getcolorfield(L, "r");
    int green = getcolorfield(L, "g");
    int blue = getcolorfield(L, "b");

    printf("red %d, green %d, blue %d\n",
            red, green, blue);
    return 0;
}
