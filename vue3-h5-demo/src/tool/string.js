
export function format_str(format, ...args) {
    let i = 0;
    return format.replace(/%[sd]/g, match => {
        const val = args[i++];
        return match === "%d" ? Number(val) : String(val);
    });
}

