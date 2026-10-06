var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

var _escala = 3; 

var _img_x = _gui_w / 2;
var _img_y = _gui_h / 2 - 50; 

// Desenha a Ampulheta
draw_sprite_ext(spr_ampulheta, 0, _img_x, _img_y, _escala, _escala, 0, c_white, alpha_imagem);

// Desenha o Texto
if (estado == 2) {
    var _current_text = text_array[text_index];
    var _text_to_draw = string_copy(_current_text, 1, floor(char_index));

    draw_set_font(-1); 
    draw_set_valign(fa_top);
    draw_set_color(c_white);

    var _altura_ampulheta = sprite_get_height(spr_ampulheta) * _escala;
    var _text_y = _img_y + (_altura_ampulheta / 2) + 40; 

    // --- EFEITO UNDERTALE (TREMOR NAS FRASES 1 E 2) ---
    if (text_index >= 1) {
        draw_set_halign(fa_left); // Alinha à esquerda para calcular a posição caractere por caractere
        
        var _largura_total = string_width(_text_to_draw);
        var _start_x = (_gui_w / 2) - (_largura_total / 2); // Centraliza a frase inteira
        var _curr_x = _start_x;
        
        var _intensidade = 2; // Quantidade de pixels que cada letra treme
        
        for (var i = 1; i <= string_length(_text_to_draw); i++) {
            var _char = string_char_at(_text_to_draw, i);
            
            // Vibração individual para cada letra
            var _shake_x = random_range(-_intensidade, _intensidade);
            var _shake_y = random_range(-_intensidade, _intensidade);
            
            draw_text(_curr_x + _shake_x, _text_y + _shake_y, _char);
            _curr_x += string_width(_char); // Avança a posição para a próxima letra
        }
    } 
    else {
        // Frase 0 ("What is time, anyway?"): Desenha normal e calmo
        draw_set_halign(fa_center);
        draw_text_ext(_gui_w / 2, _text_y, _text_to_draw, 35, 800);
    }

    // --- INDICADOR VISUAL DEFINITIVO ---
    draw_set_halign(fa_center);
    if (pode_interagir) {
        draw_set_color(c_yellow);
        draw_text(_gui_w / 2, _text_y + 80, "[ SPACEBAR / Z ]");
    }

    // RESET DE ESTADOS
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}