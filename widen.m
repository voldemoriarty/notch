function widen(h)
%widen makes bode plot lines thicc
    g = findall(h,'Type','hggroup');
    c = get(g,'Children');
    set([c{:}], 'Linewidth', 2);
end

