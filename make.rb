require "fileutils"

FileUtils.mkdir_p( "log" )
FileUtils.mkdir_p( "bin" )
A = %x(uname -m).strip

case A
when "arm64"
    [
        ["LD", "long double" ],
        ["D", "double"],
        ["F", "float" ]
    ].each do |ntn, ntd|
        [ 
            ["arm", ""],
            ["387", nil],
            ["sse", nil]
        ].each do |fpn, fpo|
            bin = "bin/" + [ntn,fpn].join("_")
            log = "log/" + [A,ntn,fpn].join("_") + ".txt"
            if fpo
                puts %x(gcc-11 -Wall -DNUM_T="#{ntd}" -std=c17 -Wall #{fpo} -fexcess-precision=standard main.c -o #{bin} 2>&1 && #{bin} && #{bin} > #{log})
            else
                puts %x(#{bin} && #{bin} > #{log})
            end
        end
    end
when "x86_64"
    [
        ["LD", "long double" ],
        ["D", "double"],
        ["F", "float" ]
    ].each do |ntn, ntd|
        [ 
            ["387", "-mfpmath=387"],
            ["sse", "-mfpmath=sse -msse2"]
        ].each do |fpn, fpo|
            bin = "bin/" + [ntn,fpn].join("_")
            log = "log/" + [A,ntn,fpn].join("_") + ".txt"
            puts %x(gcc-11 -Wall -DNUM_T="#{ntd}" -std=c17 -Wall #{fpo} -fexcess-precision=standard main.c -o #{bin} 2>&1 && #{bin} && #{bin} > #{log})
        end
    end
else
    raise "unexpected arch:#{A}"
end

