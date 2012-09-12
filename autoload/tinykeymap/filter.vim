" filter.vim
" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2012-09-09.
" @Last Change: 2012-09-09.
" @Revision:    1

function! tinykeymap#filter#Process() "{{{3
    norm! zE
    if !empty(g:tinykeymap#filter#rx)
        let pos = getpos('.')
        try
            let lend = line('$')
            let from = 0
            norm! gg0
            let to = search(g:tinykeymap#filter#rx, 'cW')
            " TLogVAR g:tinykeymap#filter#rx, from, to
            while to > 0 && from < lend
                if to > 1 && to > from + 1
                    call s:Fold(from, to - 1)
                endif
                let from = to + 1
                exec from
                let to = search(g:tinykeymap#filter#rx, 'W')
                " TLogVAR g:tinykeymap#filter#rx, from, to
            endwh
            if from > 1 && from < lend
                call s:Fold(from, lend)
            endif
        finally
            call setpos('.', pos)
        endtry
    endif
    exec printf('3match IncSearch /%s/', g:tinykeymap#filter#rx)
endf


function! s:Fold(from, to) "{{{3
    let fold = printf('%s,%sfold', a:from, a:to)
    " TLogVAR fold
    exec fold
endf


function! tinykeymap#filter#UnkownKey(chars, count) "{{{3
    let g:tinykeymap#filter#rx .= join(a:chars, '')
    return 1
endf
