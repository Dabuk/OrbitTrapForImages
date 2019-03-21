function [ new ] = main(im, xmin, xmax, ymin, ymax, const, iter, baseoption, modif, poly, showim)

% get height and width
[HEIGHT, WIDTH, chan] = size(im);

% set complex plane boundaries
RE_START = xmin;
RE_END = xmax;
IM_START = ymin;
IM_END = ymax;

% initialize output
new = zeros(WIDTH,HEIGHT,chan,'uint8');

for x=1:WIDTH
    for y=1:HEIGHT
        
        % convert pixel coordinates to complex numbers
        c = complex(RE_START + (x / WIDTH) * (RE_END - RE_START),IM_START + (y / HEIGHT) * (IM_END - IM_START));
       
        % perform recursion
        [ n,z ] = phoenix(c,const,iter,baseoption,modif, poly);
        
        % display result at iteration / all iterations
        if showim == 1
            % do nothing            
        elseif showim == 2
            if n ~= iter
                continue
            end
        end
        
        % get resulting pixel values
        r = floor((real(z) - RE_START) * WIDTH / (RE_END - RE_START));
        i = floor((imag(z) - IM_START) * HEIGHT / (IM_END - IM_START));
        
        % edge conditions if r,i outside image dimensions
        if r <= 1 || r >= WIDTH
           r = mod(r,WIDTH)+1;
        end
        
        if i <= 1 || i >=HEIGHT
           i = mod(i,HEIGHT) +1;
        end
        
        % assign new pixel values
        vals = im(i,r,:);
        new(y,x,:) = vals;
        
    end
end
end

