var _key_pressed = (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter));

// --- ATALHO: Pula Fade In (0) ou Espera (1) direto para a digitação de texto (2) ---
if ((estado == 0 || estado == 1) && _key_pressed) {
    alpha_imagem = 1;     // Garante que a ampulheta fique 100% visível
    estado = 2;           // Vai direto para o estado de texto
    pode_interagir = true;
    io_clear();           // Limpa o teclado para não autocompletar a primeira frase sem querer
}

if (estado == 0) {
    // Fade in
    alpha_imagem += velocidade_fade;
    if (alpha_imagem >= 1) {
        alpha_imagem = 1;
        estado = 1; 
    }
} 
else if (estado == 1) {
    // Pausa dramática
    tempo_espera--;
    if (tempo_espera <= 0) {
        estado = 2; 
    }
} 
else if (estado == 2) {
    var _current_text = text_array[text_index];
    var _text_length = string_length(_current_text);

    // EFEITO CÔMICO: A segunda frase digita mais rápido que a primeira (pânico)
    if (text_index == 1) {
        char_speed = 1.0; 
    }

    if (char_index < _text_length) {
        char_index += char_speed;
        if (floor(char_index) != floor(char_index - char_speed)) {
            audio_play_sound(snd_text_beep, 1, false);
        }
    }
    
    // Libera a interação imediatamente sem exigir o tempo de reflexão
    pode_interagir = true;

    if (_key_pressed && pode_interagir) {
        if (char_index < _text_length) {
            char_index = _text_length; // Se estiver digitando, completa a frase
        } 
        else {
            text_index++;              // Se já completou, avança para a próxima frase
            char_index = 0;
            
            if (text_index >= array_length(text_array)) {
                room_goto(room_game);  // Chegou ao fim, vai pro jogo
            }
        }
    }
}