function err = relative_error2(x, x_ref)
    err = norm(x - x_ref) / norm(x_ref);
end