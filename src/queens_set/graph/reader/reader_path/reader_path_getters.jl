function to_string_path(path :: PathSolutionReader) :: String
    txt = ""
    #copy_route = deepcopy(path.route)
    #popfirst!(copy_route)
    #pop!(copy_route)
    #! [for] $ O(N) $
    for color in path.route
        txt *= "$color, "
    end
    return chop(txt, tail = 2)
end
