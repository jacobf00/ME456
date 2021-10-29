function new_dh = flip_rows(dh)

[r,c] = size(dh);
new_dh = zeros(r,c);

for row=1:r
    new_row = dh(row,:);
    new_row = new_row(end:-1:1);
    new_dh(row,:) = new_row;
end

end

