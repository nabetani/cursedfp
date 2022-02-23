require "fileutils"

FileUtils.mkdir_p( "log" )
FileUtils.mkdir_p( "bin" )
A = %x(uname -m).strip

[ ["LD", "long double" ],
  ["D", "double"],
  ["F", "float" ]
 ].each do |ntn, ntd|
    [ 
        ["387", "-mfpmath=387"],
        ["sse", "-mfpmath=sse -msse2"]
    ].each do |fpn, fpo|
        bin = "bin/" + [ntn,fpn].join("_")
        log = "log/" + [A,ntn,fpn].join("_") + ".txt"
        %x(gcc-11 -DNUM_T="#{ntd}" -std=c17 -Wall #{fpo} -fexcess-precision=standard main.c -o #{bin} && #{bin} > #{log})
    end
end
