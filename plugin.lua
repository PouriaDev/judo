function photo_lower(msg)
	if msg.photo then
		i=#msg.photo
		file_size = msg.photo[i].file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		a=0
		for v=1,i do
			a=a+1
			file_size = msg.photo[a].file_size/1000
			caption = "Resolution: "..msg.photo[a].width.."x"..msg.photo[a].height.."\nSize: "..file_size.."KB\n"..bot_user
			send_photo(msg.from.id, msg.photo[a].file_id, caption)
		end
		return back(msg)
	elseif msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "jpg" or string.sub(msg.document.file_name:lower(), -3) == "png" then
			saved_file = "temp/dl"..msg.from.id.."."..string.sub(msg.document.file_name:lower(), -3)
			dl_file(saved_file, msg.document.file_id)
			converted = "temp/conv"..msg.from.id..".jpg"
			io.popen("convert "..saved_file.." -quality 50 "..converted)
			up_file(msg.from.id, converted, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *Photo File*", true)
	end
end

function html_conv(msg)
	if users[userid].sub == 1 then
		if msg.text == "HTML>EXE" then
			users[userid].sub = 2
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		elseif msg.text == "HTML>PHP" then
			users[userid].sub = 3
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		elseif msg.text == "HTML>JS" then
			users[userid].sub = 4
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		elseif msg.text == "HTML>JAVA" then
			users[userid].sub = 5
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		elseif msg.text == "HTML>HTA" then
			users[userid].sub = 6
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		elseif msg.text == "HTML>ASPX" then
			users[userid].sub = 7
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		else
			return send_msg(msg.from.id, "_You can only_ *choice a Key*", true)
		end
	end
	if msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "htm" or string.sub(msg.document.file_name:lower(), -4) == "html" then
		else
			return send_msg(msg.from.id, "_You can send only_ *HTM* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *HTM* _files_", true)
	end
end

function app_conv(msg)
	if users[userid].sub == 1 then
		if msg.text == "JAR>EXE" then
			users[userid].sub = 3
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *JAR (Java)* _file_\n`Maximum 5MB - 5000KB`", {{"Home"}}, true)
		elseif check_match(msg.text, {"BAT>CMD","BAT>PIF","CMD>BAT","CMD>PIF","EXE>SCR","SCR>EXE"}) then
			formats = msg.text:split(">")
			users[userid].input = formats[1]
			users[userid].output = formats[2]
			users[userid].sub = 2
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *"..formats[1].."* _file_\n`Maximum 5MB - 5000KB`", {{"Home"}}, true)
		else
			return send_msg(msg.from.id, "_You can only_ *choice a Key*", true)
		end
	elseif users[userid].sub == 2 then
		if msg.document then
			if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
			file_size = msg.document.file_size/1000
			if file_size > 5000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `5MB or 5000KB`", true) end
			if string.sub(msg.document.file_name:lower(), -3) == users[userid].input:lower() then
				saved_file = "temp/dl"..msg.from.id.."."..users[userid].input:lower()
				send_file(msg.from.id, msg.document.file_id, saved_file, bot_user)
				return back(msg)
			else
				return send_msg(msg.from.id, "_You can send only_ *"..users[userid].input.."* _files_", true)
			end
		else
			return send_msg(msg.from.id, "_You can send only_ *"..users[userid].input.."* _files_", true)
		end
	elseif users[userid].sub == 3 then
		return send_msg(msg.from.id, "soon", true)-----------------------------------------------------------------------
	end
end

function photo_conv(msg)
	if users[userid].sub == 1 then
		if check_match(msg.text, {"PNG>JPG","JPG>PNG","TIF>PNG","TIF>JPG","GIF>JPG","GIF>PNG","DPX>JPG","DPX>PNG"}) then
			formats = msg.text:split(">")
			users[userid].input = formats[1]
			users[userid].output = formats[2]
			users[userid].sub = 2
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *"..formats[1].."* _file_\n`Maximum 2MB - 2000KB`", {{"Home"}}, true)
		else
			return send_msg(msg.from.id, "_You can only_ *choice a Key*", true)
		end
	elseif users[userid].sub == 2 then
		if msg.document then
			if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
			file_size = msg.document.file_size/1000
			if file_size > 2000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `2MB or 2000KB`", true) end
			if string.sub(msg.document.file_name:lower(), -3) == users[userid].input:lower() then
				saved_file = "temp/dl"..msg.from.id.."."..users[userid].input:lower()
				dl_file(saved_file, msg.document.file_id)
				converted = "temp/conv"..msg.from.id.."."..users[userid].output:lower()
				io.popen("convert "..saved_file.." "..converted)
				up_file(msg.from.id, converted, bot_user)
				return back(msg)
			else
				return send_msg(msg.from.id, "_You can send only_ *"..users[userid].input.."* _files_", true)
			end
		elseif msg.photo then
			i=#msg.photo
			file_size = msg.photo[i].file_size/1000
			if file_size > 2000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `2MB or 2000KB`", true) end
			saved_file = "temp/dl"..msg.from.id.."."..users[userid].output:lower()
			dl_file(saved_file, msg.photo[i].file_id)
			up_file(msg.from.id, saved_file, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *"..users[userid].input.."* _files_", true)
		end
	end
end

function st_pic(msg)
	if msg.sticker then
		file_size = msg.sticker.file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		file_info = "_Sticker Information:_\n"
			.."*Sticker Resolution:* `"..msg.sticker.width.."x"..msg.sticker.height.."`\n"
			.."*Sticker Size:* `"..file_size.."KB`\n"
			.."*Sticker Emoji:* "..(msg.sticker.emoji or "`None`")..bot_user
		send_msg(msg.from.id, file_info, true)
		sticker_photo(msg.chat.id, msg.sticker.file_id, bot_user)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Sticker* _files_", true)
	end
end

function st_file(msg)
	if msg.sticker then
		file_size = msg.sticker.file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		file_info = "_Sticker Information:_\n"
			.."*Sticker Resolution:* `"..msg.sticker.width.."x"..msg.sticker.height.."`\n"
			.."*Sticker Size:* `"..file_size.."KB`\n"
			.."*Sticker Emoji:* "..(msg.sticker.emoji or "`None`")..bot_user
		send_msg(msg.from.id, file_info, true)
		sticker_file(msg.chat.id, msg.sticker.file_id, bot_user)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Sticker* _files_", true)
	end
end

function pic_st(msg)
	if msg.photo then
		i=#msg.photo
		file_size = msg.photo[i].file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		file_info = "_Photo Information:_\n"
		.."*Photo Resolution:* `"..msg.photo[i].width.."x"..msg.photo[i].height.."`\n"
		.."*Photo Size:* `"..file_size.."KB`"..bot_user
		send_msg(msg.from.id, file_info, true)
		photo_sticker(msg.chat.id, msg.photo[i].file_id)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
	end
end

function pic_file(msg)
	if msg.photo then
		i=#msg.photo
		file_size = msg.photo[i].file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		file_info = "_Photo Information:_\n"
		.."*Photo Resolution:* `"..msg.photo[i].width.."x"..msg.photo[i].height.."`\n"
		.."*Photo Size:* `"..file_size.."KB`"..bot_user
		send_msg(msg.from.id, file_info, true)
		photo_file(msg.chat.id, msg.photo[i].file_id, bot_user)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
	end
end

function vid_file(msg)
	if msg.video then
		file_size = msg.video.file_size/1000
		if file_size > 5000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `5MB or 5000KB`", true) end
		file_info = "_Video Information:_\n"
		.."*Video Resolution:* `"..msg.video.width.."x"..msg.video.height.."`\n"
		.."*Video Size:* `"..file_size.."KB`\n"
		.."*Video Time:* `"..(msg.video.duration/60).."min`"..bot_user
		send_msg(msg.from.id, file_info, true)
		video_file(msg.chat.id, msg.video.file_id, bot_user)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Video* _files_", true)
	end
end

function vid_gif(msg)
	if msg.video then
		file_size = msg.video.file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		file_info = "_Video Information:_\n"
		.."*Video Resolution:* `"..msg.video.width.."x"..msg.video.height.."`\n"
		.."*Video Size:* `"..file_size.."KB`\n"
		.."*Video Time:* `"..(msg.video.duration/60).."min`"..bot_user
		send_msg(msg.from.id, file_info, true)
		video_gif(msg.chat.id, msg.video.file_id, bot_user)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Video* _files_", true)
	end
end

function gif_vid(msg)
	if msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "gif" or string.sub(msg.document.file_name:lower(), -3) == "mp4" then
			file_info = "_File Information:_\n"
			.."*File Size:* `"..file_size.."KB`\n"
			.."*File Name:* `"..msg.document.file_name.."`"..bot_user
			send_msg(msg.from.id, file_info, true)
			gif_video(msg.chat.id, msg.document.file_id, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *Gif* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *Gif* _files_", true)
	end
end

function aud_voi(msg)
	if msg.audio then
		file_size = msg.audio.file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		file_info = "_Audio Information:_\n"
		.."*Audio Size:* `"..file_size.."KB`\n"
		.."*Audio Time:* `"..(msg.audio.duration/60).."min`"..bot_user
		send_msg(msg.from.id, file_info, true)
		audio_voice(msg.chat.id, msg.audio.file_id)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Audio* _files_", true)
	end
end

function voi_aud(msg)
	if msg.voice then
		file_size = msg.voice.file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		file_info = "_Voice Information:_\n"
		.."*Voice Size:* `"..file_size.."KB`\n"
		.."*Voice Time:* `"..(msg.voice.duration/60).."min`"..bot_user
		send_msg(msg.from.id, file_info, true)
		voice_audio(msg.chat.id, msg.voice.file_id, bot.first_name, msg.voice.duration, bot.username)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Voice* _files_", true)
	end
end

function qr_reader(msg)
	if msg.photo then
		i=#msg.photo
		file_size = msg.photo[i].file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		photo_file = msg.photo[i].file_id
		photo_data = https.request(send_api.."/getFile?file_id="..photo_file)
		jtab = json.decode(photo_data)
		scan = http.request("http://api.qrserver.com/v1/read-qr-code/?fileurl=https://api.telegram.org/file/bot"..bot_token.."/"..jtab.result.file_path)
		jtab = json.decode(scan)
		if jtab[1].symbol[1].data == nil or jtab[1].symbol[1].data == false then
			if jtab[1].symbol[1]["error"] == "could not find/read QR Code" then
				return send_msg(msg.from.id, "_You'r file_ *is NOT QR Code*", true)
			else
				return send_msg(msg.from.id, jtab[1].symbol[1]["error"], false)
			end
		else
			send_msg(msg.from.id, "QR Code Data:\n______________________________\n"..jtab[1].symbol[1].data.."\n______________________________\n"..bot_user, false)
			return back(msg)
		end
	else
		return send_msg(msg.from.id, "_You'r file_ *is NOT QR Code*", true)
	end
end

function qr_make(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if string.len(msg.text) > 200 then
		return send_msg(msg.from.id, "*Maximum* _text characters is_ *200*", true)
	end
	photo = http.request("http://api.qrserver.com/v1/create-qr-code/?data="..url.escape(msg.text).."&size=512x512&color=000000&bgcolor=ffffff&margin=15&format=png")
	f = io.open("temp/QR.png", "w+")
	f:write(photo)
	f:close()
	local send = send_api.."/sendPhoto"
	local curl_command = 'curl "'..send..'" -F "chat_id='..msg.from.id..'" -F "photo=@temp/QR.png" -F "caption='..bot_user..'"'
	io.popen(curl_command):read("*all")
	return back(msg)
end

function qr_voi(msg)
	if msg.photo then
		i=#msg.photo
		file_size = msg.photo[i].file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		photo_file = msg.photo[i].file_id
		photo_data = https.request(send_api.."/getFile?file_id="..photo_file)
		jtab = json.decode(photo_data)
		scan = http.request("http://api.qrserver.com/v1/read-qr-code/?fileurl=https://api.telegram.org/file/bot"..bot_token.."/"..jtab.result.file_path)
		jtab = json.decode(scan)
		if jtab[1].symbol[1].data == nil or jtab[1].symbol[1].data == false then
			if jtab[1].symbol[1]["error"] == "could not find/read QR Code" then
				return send_msg(msg.from.id, "_You'r file_ *is NOT QR Code*", true)
			else
				return send_msg(msg.from.id, jtab[1].symbol[1]["error"], false)
			end
		else
			i = jtab[1].symbol[1].data
			if i:find('[ا|ب|پ|ت|ث|ج|چ|ح|خ|د|ذ|ر|ز|ژ|س|ش|ص|ض|ط|ظ|ع|غ|ف|ق|ک|گ|ل|م|ن|و|ه|ی|ي|ء|أ|إ|ؤ|ة|آ|ۀ]') then
				return send_msg(msg.from.id, "_You can only use_ *English* _QR Code_", true)
			end
			data = io.popen("curl 'https://api.voicerss.org/?key=ac4bf3739b4e4838989e995deaaddb68&src="..url.escape(jtab[1].symbol[1].data).."&hl=en-us&r=-2&c=MP3&f=8khz_8bit_stereo'"):read('*all')
			f = io.open("temp/QR_tts.mp3", "w+")
			f:write(data)
			f:close()
			send_voice(msg.from.id, "temp/QR_tts.mp3")
			return back(msg)
		end
	else
		return send_msg(msg.from.id, "_You'r file_ *is NOT QR Code*", true)
	end
end

function bar_make(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if string.len(msg.text) > 50 then
		return send_msg(msg.from.id, "*Maximum* _number characters is_ *50*", true)
	end
	if not string.match(msg.text, '^%d+$') then
		return send_msg(msg.from.id, "_You can only use_ *Numbers*", true)
	end
	photo = http.request("http://www.barcodes4.me/barcode/c128c/"..url.escape(msg.text)..".png?width=500&height=170&istextdrawn=1")
	f = io.open("temp/BarCode.png", "w+")
	f:write(photo)
	f:close()
	local send = send_api.."/sendPhoto"
	local curl_command = 'curl "'..send..'" -F "chat_id='..msg.from.id..'" -F "photo=@temp/BarCode.png" -F "caption='..bot_user..'"'
	io.popen(curl_command):read("*all")
	return back(msg)
end

function hash_en(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if string.len(msg.text) > 200 then
		return send_msg(msg.from.id, "*Maximum* _text characters is_ *200*", true)
	end
	cmd = io.popen('echo "'..msg.text..'" | base64 -w0'):read("*all")
	send_msg(msg.from.id, cmd.."\n"..bot_user, false)
	return back(msg)
end

function hash_de(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if string.len(msg.text) > 100 then
		return send_msg(msg.from.id, "*Maximum* _hash characters is_ *1000*", true)
	end
	cmd = io.popen('echo "'..msg.text..'" | base64 -d'):read("*all")
	send_msg(msg.from.id, cmd.."\n"..bot_user, false)
	return back(msg)
end

function tts_voi(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	i = msg.text
	if i:find('[ا|ب|پ|ت|ث|ج|چ|ح|خ|د|ذ|ر|ز|ژ|س|ش|ص|ض|ط|ظ|ع|غ|ف|ق|ک|گ|ل|م|ن|و|ه|ی|ي|ء|أ|إ|ؤ|ة|آ|ۀ]') then
		return send_msg(msg.from.id, "_You can only use_ *English* _characters_", true)
	end
	data = io.popen("curl 'https://api.voicerss.org/?key=ac4bf3739b4e4838989e995deaaddb68&src="..url.escape(msg.text).."&hl=en-us&r=-2&c=MP3&f=8khz_8bit_stereo'"):read('*all')
	f = io.open("temp/tts.mp3", "w+")
	f:write(data)
	f:close()
	send_voice(msg.from.id, "temp/tts.mp3")
	return back(msg)
end

function tts_aou(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	i = msg.text
	if i:find('[ا|ب|پ|ت|ث|ج|چ|ح|خ|د|ذ|ر|ز|ژ|س|ش|ص|ض|ط|ظ|ع|غ|ف|ق|ک|گ|ل|م|ن|و|ه|ی|ي|ء|أ|إ|ؤ|ة|آ|ۀ]') then
		return send_msg(msg.from.id, "_You can only use_ *English* _characters_", true)
	end
	data = io.popen("curl 'https://api.voicerss.org/?key=ac4bf3739b4e4838989e995deaaddb68&src="..url.escape(msg.text).."&hl=en-us&r=-2&c=MP3&f=48khz_16bit_stereo'"):read('*all')
	f = io.open("temp/tts.mp3", "w+")
	f:write(data)
	f:close()
	up_file(msg.from.id, "temp/tts.mp3", bot_user)
	return back(msg)
end

function file_vid(msg)
	if msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 5000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `5MB or 5000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "avi" or string.sub(msg.document.file_name:lower(), -3) == "3gp" or string.sub(msg.document.file_name:lower(), -3) == "mov" or string.sub(msg.document.file_name:lower(), -3) == "mp4" then
			saved_file = "temp/dl"..msg.from.id..".avi"
			dl_file(saved_file, msg.document.file_id)
			send_video(msg.from.id, saved_file, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *Video* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *Video* _files_", true)
	end
end

function file_pic(msg)
	if msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "png" or string.sub(msg.document.file_name:lower(), -3) == "jpg" or string.sub(msg.document.file_name:lower(), -3) == "gif" or string.sub(msg.document.file_name:lower(), -4) == "jpeg" then
			saved_file = "temp/dl"..msg.from.id..".jpg"
			dl_file(saved_file, msg.document.file_id)
			send_pic(msg.from.id, saved_file, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
	end
end

function file_st(msg)
	if msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "png" or string.sub(msg.document.file_name:lower(), -3) == "jpg" or string.sub(msg.document.file_name:lower(), -3) == "gif" or string.sub(msg.document.file_name:lower(), -4) == "jpeg" then
			saved_file = "temp/dl"..msg.from.id..".webp"
			dl_file(saved_file, msg.document.file_id)
			send_st(msg.from.id, saved_file)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
	end
end

function font(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if users[userid].sub == 1 then
		if string.len(msg.text) > 30 then
			return send_msg(msg.from.id, "_You can only send_ *30 Characters*", true)
		end
		fonts_key = {{"Home"},{"1- ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜ"},{"2- ⒜⒝⒞⒟⒠⒡⒢⒣⒤⒥⒦⒧⒨"},{"3- αвc∂єƒgнιנкℓм"},{"4- αвcdeғɢнιjĸlм"},{"5- αв¢đefgħıנκłм"},
			{"6- ąҍçժҽƒցհìʝҟӀʍղ"},{"7- คც८ძ૯Բ૭ҺɿʆқՆɱ"},{"8- αßςdεƒghïյκﾚm"},{"9- ค๒ς๔єŦɠђเןкl๓"},{"10- ﾑ乃ζÐ乇ｷǤんﾉﾌズﾚᄊ"},{"11- αβcδεŦĝhιjκlʍ"},
			{"12- ձъƈժεբցհﻨյĸlო"},{"13- Λɓ¢Ɗ£ƒɢɦĩʝҚŁɱ"},{"14- ΛБϾÐΞŦGHłJКŁM"},{"15- ɐqɔpǝɟɓɥıſʞๅɯ"},{"16- ɒdɔbɘʇϱнiįʞlм"},{"17- A̴̴B̴̴C̴̴D̴̴E̴̴F̴̴G̴̴H̴̴I̴̴J̴̴K̴̴L̴̴M̴"}}
		users[userid].texts = msg.text
		users[userid].sub = 2
		save_data("users.json", users)
		return send_key(msg.from.id, "_choice a_ *Font* _of keys_", fonts_key, true)
	elseif users[userid].sub == 2 then
		if msg.text:find('17') then
			i=17
		elseif msg.text:find('16') then
			i=16
		elseif msg.text:find('15') then
			i=15
		elseif msg.text:find('14') then
			i=14
		elseif msg.text:find('13') then
			i=13
		elseif msg.text:find('12') then
			i=12
		elseif msg.text:find('11') then
			i=11
		elseif msg.text:find('10') then
			i=10
		elseif msg.text:find('9') then
			i=9
		elseif msg.text:find('8') then
			i=8
		elseif msg.text:find('7') then
			i=7
		elseif msg.text:find('6') then
			i=6
		elseif msg.text:find('5') then
			i=5
		elseif msg.text:find('4') then
			i=4
		elseif msg.text:find('3') then
			i=3
		elseif msg.text:find('2') then
			i=2
		elseif msg.text:find('1') then
			i=1
		end
		
		font_base = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,9,8,7,6,5,4,3,2,1,.,_"
		font_hash = "z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,0,1,2,3,4,5,6,7,8,9,.,_"
		fonts = {
			"ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,⓪,➈,➇,➆,➅,➄,➃,➂,➁,➀,●,_",
			"⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⓪,⑼,⑻,⑺,⑹,⑸,⑷,⑶,⑵,⑴,.,_",
			"α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,⊘,९,𝟠,7,Ϭ,Ƽ,५,Ӡ,ϩ,𝟙,.,_",
			"ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,Q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ᅙ,9,8,ᆨ,6,5,4,3,ᆯ,1,.,_",
			"α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
			"Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,0,9,8,7,6,5,4,3,2,1,.,_",
			"Λ,Б,Ͼ,Ð,Ξ,Ŧ,G,H,ł,J,К,Ł,M,Л,Ф,P,Ǫ,Я,S,T,U,V,Ш,Ж,Џ,Z,Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"A̴,̴B̴,̴C̴,̴D̴,̴E̴,̴F̴,̴G̴,̴H̴,̴I̴,̴J̴,̴K̴,̴L̴,̴M̴,̴N̴,̴O̴,̴P̴,̴Q̴,̴R̴,̴S̴,̴T̴,̴U̴,̴V̴,̴W̴,̴X̴,̴Y̴,̴Z̴,̴a̴,̴b̴,̴c̴,̴d̴,̴e̴,̴f̴,̴g̴,̴h̴,̴i̴,̴j̴,̴k̴,̴l̴,̴m̴,̴n̴,̴o̴,̴p̴,̴q̴,̴r̴,̴s̴,̴t̴,̴u̴,̴v̴,̴w̴,̴x̴,̴y̴,̴z̴,̴0̴,̴9̴,̴8̴,̴7̴,̴6̴,̴5̴,̴4̴,̴3̴,̴2̴,̴1̴,̴.̴,̴_̴",
		}
		
		local tar_font = fonts[i]:split(",")
		local text = users[userid].texts
		local text = text:gsub("A",tar_font[1])
		local text = text:gsub("B",tar_font[2])
		local text = text:gsub("C",tar_font[3])
		local text = text:gsub("D",tar_font[4])
		local text = text:gsub("E",tar_font[5])
		local text = text:gsub("F",tar_font[6])
		local text = text:gsub("G",tar_font[7])
		local text = text:gsub("H",tar_font[8])
		local text = text:gsub("I",tar_font[9])
		local text = text:gsub("J",tar_font[10])
		local text = text:gsub("K",tar_font[11])
		local text = text:gsub("L",tar_font[12])
		local text = text:gsub("M",tar_font[13])
		local text = text:gsub("N",tar_font[14])
		local text = text:gsub("O",tar_font[15])
		local text = text:gsub("P",tar_font[16])
		local text = text:gsub("Q",tar_font[17])
		local text = text:gsub("R",tar_font[18])
		local text = text:gsub("S",tar_font[19])
		local text = text:gsub("T",tar_font[20])
		local text = text:gsub("U",tar_font[21])
		local text = text:gsub("V",tar_font[22])
		local text = text:gsub("W",tar_font[23])
		local text = text:gsub("X",tar_font[24])
		local text = text:gsub("Y",tar_font[25])
		local text = text:gsub("Z",tar_font[26])
		local text = text:gsub("a",tar_font[27])
		local text = text:gsub("b",tar_font[28])
		local text = text:gsub("c",tar_font[29])
		local text = text:gsub("d",tar_font[30])
		local text = text:gsub("e",tar_font[31])
		local text = text:gsub("f",tar_font[32])
		local text = text:gsub("g",tar_font[33])
		local text = text:gsub("h",tar_font[34])
		local text = text:gsub("i",tar_font[35])
		local text = text:gsub("j",tar_font[36])
		local text = text:gsub("k",tar_font[37])
		local text = text:gsub("l",tar_font[38])
		local text = text:gsub("m",tar_font[39])
		local text = text:gsub("n",tar_font[40])
		local text = text:gsub("o",tar_font[41])
		local text = text:gsub("p",tar_font[42])
		local text = text:gsub("q",tar_font[43])
		local text = text:gsub("r",tar_font[44])
		local text = text:gsub("s",tar_font[45])
		local text = text:gsub("t",tar_font[46])
		local text = text:gsub("u",tar_font[47])
		local text = text:gsub("v",tar_font[48])
		local text = text:gsub("w",tar_font[49])
		local text = text:gsub("x",tar_font[50])
		local text = text:gsub("y",tar_font[51])
		local text = text:gsub("z",tar_font[52])
		local text = text:gsub("0",tar_font[53])
		local text = text:gsub("9",tar_font[54])
		local text = text:gsub("8",tar_font[55])
		local text = text:gsub("7",tar_font[56])
		local text = text:gsub("6",tar_font[57])
		local text = text:gsub("5",tar_font[58])
		local text = text:gsub("4",tar_font[59])
		local text = text:gsub("3",tar_font[60])
		local text = text:gsub("2",tar_font[61])
		local text = text:gsub("1",tar_font[62])
		send_msg(msg.from.id, text.."\n"..bot_user, false)
		return back(msg)
	end
end

function nashr(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	local input = msg.text:trim()
	if input:len() > 20 then
		return send_msg(msg.from.id, "_You can only send_ *20 Characters*", true)
	end
	local input = input:upper()
	local output = ''
	local inc = 0
	for match in input:gmatch('.') do
		output = output..match..' '
	end
	local output = output..'\n'
	for match in input:sub(2):gmatch('.') do
		local spacing = ''
		for i = 1, inc do
			spacing = spacing..'  '
		end
		inc = inc + 1
		output = output..match..' '..spacing..match..'\n'
	end
	local final = "```\n"..output:trim().."\n```"
	send_msg(msg.from.id, final, true)
	return back(msg)
end

function txt_pic(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if users[userid].sub == 1 then
		if string.len(msg.text) > 500 then
			return send_msg(msg.from.id, "_You can only send_ *500 Characters*", true)
		elseif string.len(msg.text) > 400 then
			users[userid].fsize = "15"
		elseif string.len(msg.text) > 300 then
			users[userid].fsize = "20"
		elseif string.len(msg.text) > 200 then
			users[userid].fsize = "25"
		elseif string.len(msg.text) > 100 then
			users[userid].fsize = "30"
		else
			users[userid].fsize = "35"
		end
		users[userid].texts = msg.text
		users[userid].sub = 2
		save_data("users.json", users)
		fonts_key = {{"Home"},{"Arial","Comic","Dyslexic"},{"Georgia","Impact","Lucida"},{"Simsun","Tahoma","Times"},{"Trebuchet","Verdana"}}
		return send_key(msg.from.id, "_choice a_ *Font* _of keys_", fonts_key, true)
	elseif users[userid].sub == 2 then
		if check_match(msg.text:lower(), {"arial","comic","dyslexic","georgia","impact","lucida","simsun","tahoma","times","trebuchet","verdana"}) then
			users[userid].font = msg.text:lower()
			users[userid].sub = 3
			save_data("users.json", users)
			color_key = {{"Home"},{"Black","Gray"},{"Green","Blue"},{"Yellow","Red"}}
			return send_key(msg.from.id, "_choice_ *Font Color* _of keys_", color_key, true)
		else
			return send_msg(msg.from.id, "_choice a_ *Font* _of keys_", true)
		end
	elseif users[userid].sub == 3 then
		if check_match(msg.text:lower(), {"black","gray","green","blue","yellow","red"}) then
			if msg.text:lower() == "black" then
				users[userid].color = "000000"
			elseif msg.text:lower() == "gray" then
				users[userid].color = "999999"
			elseif msg.text:lower() == "green" then
				users[userid].color = "00ff00"
			elseif msg.text:lower() == "blue" then
				users[userid].color = "0000ff"
			elseif msg.text:lower() == "yellow" then
				users[userid].color = "ffff00"
			elseif msg.text:lower() == "red" then
				users[userid].color = "ff0000"
			end
			users[userid].sub = 4
			save_data("users.json", users)
			color_key = {{"Home"},{"Transparent","White","Gray"},{"Green","Blue"},{"Yellow","Red"}}
			return send_key(msg.from.id, "_choice_ *Background Color* _of keys_", color_key, true)
		else
			return send_msg(msg.from.id, "_choice_ *Font Color* _of keys_", true)
		end
	elseif users[userid].sub == 4 then
		if check_match(msg.text:lower(), {"transparent","white","gray","green","blue","yellow","red"}) then
			if msg.text:lower() == "transparent" then
				bg = false
			elseif msg.text:lower() == "white" then
				bg = "ffffff"
			elseif msg.text:lower() == "gray" then
				bg = "999999"
			elseif msg.text:lower() == "green" then
				bg = "00ff00"
			elseif msg.text:lower() == "blue" then
				bg = "0000ff"
			elseif msg.text:lower() == "yellow" then
				bg = "ffff00"
			elseif msg.text:lower() == "red" then
				bg = "ff0000"
			end
			if bg then
				surl = "http://api.img4me.com/?text="..url.escape(users[userid].texts).."&font="..users[userid].font.."&fcolor="..users[userid].color.."&size="..users[userid].fsize.."&bcolor="..bg.."&type=png"
			else
				surl = "http://api.img4me.com/?text="..url.escape(users[userid].texts).."&font="..users[userid].font.."&fcolor="..users[userid].color.."&size="..users[userid].fsize.."&type=png"
			end
			file = http.request(surl)
			saved_file = "temp/dl"..msg.from.id..".png"
			file = http.request(file)
			f = io.open(saved_file, "w+")
			f:write(file)
			f:close()
			send_pic(msg.from.id, saved_file, bot_user)
			up_file(msg.from.id, saved_file, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_choice_ *Background Color* _of keys_", true)
		end
	end
end

function txt_file(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	f = io.open("temp/"..msg.from.id..".txt", "w+")
	f:write(msg.text)
	f:close()
	up_file(msg.from.id, "temp/"..msg.from.id..".txt", "Characters: "..string.len(msg.text).."\n"..bot_user)
	return back(msg)
end

function action(msg)
	if users[userid].action == 1 then
		return send_msg(msg.from.id, "soon", true) ------------------------------------------------------- edit
	elseif users[userid].action == 2 then
		return photo_conv(msg)
	elseif users[userid].action == 3 then
		return photo_lower(msg)
	elseif users[userid].action == 4 then
		return send_msg(msg.from.id, "soon", true) ------------------------  return pdf_conv(msg)
	elseif users[userid].action == 5 then
		return app_conv(msg)
	elseif users[userid].action == 6 then
		return html_conv(msg)
	elseif users[userid].action == 7 then
		return st_pic(msg)
	elseif users[userid].action == 8 then
		return st_file(msg)
	elseif users[userid].action == 9 then
		return file_st(msg)
	elseif users[userid].action == 10 then
		return pic_st(msg)
	elseif users[userid].action == 11 then
		return pic_file(msg)
	elseif users[userid].action == 12 then
		return file_pic(msg)
	elseif users[userid].action == 13 then
		return txt_pic(msg)
	elseif users[userid].action == 14 then
		return send_msg(msg.from.id, "soon", true) ----------------------------photo>exe
	elseif users[userid].action == 15 then
		return vid_file(msg)
	elseif users[userid].action == 16 then	
		return file_vid(msg)
	elseif users[userid].action == 17 then
		return vid_gif(msg)
	elseif users[userid].action == 18 then
		return gif_vid(msg)
	elseif users[userid].action == 19 then
		return aud_voi(msg)
	elseif users[userid].action == 20 then
		return voi_aud(msg)
	elseif users[userid].action == 21 then
		return tts_voi(msg)
	elseif users[userid].action == 22 then
		return tts_aou(msg)
	elseif users[userid].action == 23 then
		return qr_reader(msg)
	elseif users[userid].action == 24 then
		return qr_voi(msg)
	elseif users[userid].action == 25 then
		return qr_make(msg)
	elseif users[userid].action == 26 then
		return bar_make(msg)
	elseif users[userid].action == 27 then
		return font(msg)
	elseif users[userid].action == 28 then
		return style(msg)
	elseif users[userid].action == 29 then
		return hash_en(msg)
	elseif users[userid].action == 30 then
		return hash_de(msg)
	elseif users[userid].action == 31 then
		return nashr(msg)
	elseif users[userid].action == 32 then
		return txt_file(msg)
	end
end

function back(msg)
	users[userid].action = 0
	save_data("users.json", users)
	return send_key(msg.from.id, "*HOME*", keyboard)
end

function check_match(txt, tab)
	ret = false
	for i=1,#tab do
		if txt == tab[i] then
			ret = true
		end
	end
	return ret
end

function run(msg)
	help_admin = [[_Admin Commands:_
	
   *Block a user:*
     `/block {telegram id}`
	 
   *Unblock a user:*
     `/unblock {telegram id}`
	 
   *Block list:*
     /blocklist
	 
   *Send message to all users:*
     `/sendtoall {message}`
	 
   *All users list:*
     /users]]
	help_user = [[*Help For Options:*
	
Photo Lower: `in this service you can send image file or photo for change to lowe size.`

App Convertor: `convert windows programs.`

HTML Convertor: `convert html to other platforms.`

Sticker>Photo: `convert sticker to photo.`

Sticker>File: `converter...`

File>Sticker: `converter...`

Photo>Sticker: `converter...`

Photo>File: `converter...`

File>Photo: `converter...`

Text>Photo: `makge iname of yor text optional`

Photo>EXE: `make photo gallery for windows`

Video>Gif: `converter...`

Gif>Video: `converter...`

Video>File: `converter...`

File>Video: `converter...`

Audio>Vioce: `converter...`

Voice>Audio: `converter...`

Text>Voice: `make voice of you'r text`

Text>Audio: `make audio of you'r text`

QR-Code>Text: `read qr code photos`

QR-Code>Voice: `read qr code photos`

Text>QR-Code: `make qr code`

Text>BarCode: `make barcode`

Text>Font: `write fantasy texts optional`

Text>Nashr: `write nashr texts`

Text>File: `make text file`

Text>Hash-B64: `encode hash base 64`

Hash-B64>Text: `decode hash base 64`]]
	about_key = {{{text = "Website" , url = "http://Umbrella.shayan-soft.ir"}},{{text = "Channel" , url = "https://telegram.me/UmbrellaTeam"}},{{text = "Robot" , url = "https://telegram.me/UmbreIIaBot"}},{{text = "Instagram" , url = "https://instagram.com/UmbrellaTeam"}},{{text = "Messanger Bot" , url = "https://telegram.me/shayansoftBot"}},{{text = "Admin" , url = "https://telegram.me/shayan_soft"}}}
	about_txt = "*(Wizard) Jadu Robot* v"..bot_version.."\n_Wizard converter, maker, changer and editor robot._\n\n`Made in Umbrella Team and Powered by shayan soft Co. Group`\nProgrammer and Idea:\n[Engineer Shayan Ahmadi](https://instagram.com/shayan_soft)\nDesigner and Logo:\n[Mir Hoseyn Bayatpur](https://telegram.me/miro3ein)\nSpecial thanks to:\n[Parsa Daneshvar](https://telegram.me/prsrobot)"
	start_txt = "*Welcome to "..bot.first_name.."*\n`This robot is Free for ever...\nIn this robot you can Convert, Make, Edit and Change Files...`"
	keyboard = {
		{"About","Help"},
		{"--------------------"},
		--{"Photo Editor","PDF Convertor"},,"Photo Convertor"
		{"Photo Lower"},{"App Convertor","HTML Convertor"},
		{"--------------------"},
		{"Sticker>Photo","Sticker>File","File>Sticker"},{"Photo>Sticker","Photo>File","File>Photo"},{"Text>Photo","Photo>EXE"},
		{"--------------------"},
		{"Video>Gif","Gif>Video"},{"Video>File","File>Video"},
		{"--------------------"},
		{"Audio>Vioce","Voice>Audio"},{"Text>Voice","Text>Audio"},
		{"--------------------"},
		{"QR-Code>Text","QR-Code>Voice"},{"Text>QR-Code","Text>BarCode"},
		{"--------------------"},
		{"Text>Font","Text>Style","Text>Nashr"},{"Text>File","Text>Hash-B64","Hash-B64>Text"}
		}
	blocks = load_data("../blocks.json")
	users = load_data("users.json")
	userid = tostring(msg.from.id)
	bot_user = "\n@"..bot.username
	
	if not users[userid] then
		users[userid] = {}
		users[userid].action = 0
		save_data("users.json", users)
		return send_key(msg.from.id, start_txt, keyboard)
	end
	
	if check_match(msg.text:lower(), {"/start","home","back"}) then
		if users[userid] then
			return back(msg)
		else
			return send_key(msg.from.id, start_txt, keyboard)
		end
	elseif check_match(msg.text:lower(), {"/about","about"}) then
		return send_inline(msg.from.id, about_txt, about_key)
	elseif check_match(msg.text:lower(), {"/help","help"}) then
		if msg.from.id == sudo_id then
			return send_msg(msg.from.id, help_admin, true)
		else
			return send_msg(msg.from.id, help_user, true)
		end
	elseif msg.text:lower() == "--------------------" then
		return send_msg(msg.from.id, "_This is level line and_ *Nothing!*", true)
	elseif msg.text:find('/sendtoall') and msg.from.id == sudo_id then
		local usertarget = msg.text:input()
		if usertarget then
			i=0
			for k,v in pairs(users) do
				i=i+1
				send_msg(k, usertarget, true)
			end
			return send_msg(sudo_id, "`پیام شما به "..i.." نفر ارسال شد`", true)
		else
			return send_msg(sudo_id, "*/sendtoall test*\n`/sendtoall [message]`", true)
		end
	elseif msg.text == "/users" and msg.from.id == sudo_id then
		local list = ""
		i=0
		for k,v in pairs(users) do
			i=i+1
			list = list..i.."- "..k.."\n"
		end
		return send_msg(sudo_id, "لیست اعضا:\n\n"..list, false)
	elseif msg.text == "/blocklist" and msg.from.id == sudo_id then
		local list = ""
		i=0
		for k,v in pairs(blocks) do
			if v then
				i=i+1
				list = list..i.."- "..k.."\n"
			end
		end
		return send_msg(sudo_id, "بلاک لیست:\n\n"..list, false)
	elseif msg.text:find('/block') and msg.from.id == sudo_id then
		local usertarget = msg.text:input()
		if usertarget then
			if tonumber(usertarget) == sudo_id or tonumber(usertarget) == bot.id then
				return send_msg(sudo_id, "`نمیتوانید خودتان را بلاک کنید`", true)
			end
			if blocks[tostring(usertarget)] then
				return send_msg(sudo_id, "`شخص مورد نظر بلاک است`", true)
			end
			blocks[tostring(usertarget)] = true
			save_data("../blocks.json", blocks)
			send_msg(tonumber(usertarget), "`شما بلاک شدید!`", true)
			return send_msg(sudo_id, "`شخص مورد نظر بلاک شد`", true)
		else
			return send_msg(sudo_id, "`بعد از این دستور آی دی شخص مورد نظر را با درج یک فاصله وارد کنید`", true)
		end
	elseif msg.text:find('/unblock') and msg.from.id == sudo_id then
		local usertarget = msg.text:input()
		if usertarget then
			if blocks[tostring(usertarget)] then
				blocks[tostring(usertarget)] = false
				save_data("../blocks.json", blocks)
				send_msg(tonumber(usertarget), "`شما آنبلاک شدید!`", true)
				return send_msg(sudo_id, "`شخص مورد نظر آنبلاک شد`", true)
			end
			return send_msg(sudo_id, "`شخص مورد نظر بلاک نیست`", true)
		else
			return send_msg(sudo_id, "`بعد از این دستور آی دی شخص مورد نظر را با درج یک فاصله وارد کنید`", true)
		end
	end
	
	if users[userid].action > 0 then
		return action(msg)
	end
	
	if msg.text:lower() == "photo editor" then
		users[userid].action = 1
		send_key(msg.from.id, "_choice a_ *Option* _for_ *Edit Photo*", {{"Home"},{"Resize","Rotate"},{"Quality","Contrast","Brightnes"},{"Gamma","Noise","Segment","blur"},{"Radial","Border","Raise","scale"}}, true)
	elseif msg.text:lower() == "photo convertor" then
		users[userid].action = 2
		send_key(msg.from.id, "_choice a key for convert_ *Input > Output*", {{"Home"},{"PNG>JPG","JPG>PNG"},{"TIF>PNG","TIF>JPG","GIF>JPG"},{"GIF>PNG","DPX>JPG","DPX>PNG"}}, true)
	elseif msg.text:lower() == "photo lower" then
		users[userid].action = 3
		send_key(msg.from.id, "_Send a_ *Photo*\n`Maximum 3MB - 3000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "pdf convertor" then
		users[userid].action = 4
		send_key(msg.from.id, "_choice a key for convert_ *Input > Output*", {{"Home"},{"PDF>TIFF","TIFF>PDF"},{"PDF>JPG","JPG>PDF"},{"PDF>PNG","PNG>PDF"}}, true)
	elseif msg.text:lower() == "app convertor" then
		users[userid].action = 5
		send_key(msg.from.id, "_choice a key for convert_ *Input > Output*", {{"Home"},{"BAT>CMD","BAT>PIF","CMD>BAT","CMD>PIF"},{"JAR>EXE","EXE>SCR","SCR>EXE"}}, true)
	elseif msg.text:lower() == "html convertor" then
		users[userid].action = 6
		send_key(msg.from.id, "_choice a key for convert_ *Input > Output*", {{"Home"},{"HTML>PHP","HTML>ASPX","HTML>HTA"},{"HTML>JAVA","HTML>JS","HTML>EXE"}}, true)
	end
	
	if msg.text:lower() == "sticker>photo" then
		users[userid].action = 7
		send_key(msg.from.id, "_Send now a_ *Sticker*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "sticker>file" then
		users[userid].action = 8
		send_key(msg.from.id, "_Send now a_ *Sticker*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "file>sticker" then
		users[userid].action = 9
		send_key(msg.from.id, "_Send now a_ *File*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "photo>sticker" then
		users[userid].action = 10
		send_key(msg.from.id, "_Send now a_ *Photo*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "photo>file" then
		users[userid].action = 11
		send_key(msg.from.id, "_Send now a_ *Photo*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "file>photo" then
		users[userid].action = 12
		send_key(msg.from.id, "_Send now a_ *File*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>photo" then
		users[userid].action = 13
		send_key(msg.from.id, "_Send now _ *Text*\n`Maximum 500 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "photo>exe" then
		users[userid].action = 14
		send_key(msg.from.id, "_Send now _ *Photo*\n`Maximum 10File x (1MB-1000KB)`", {{"Home"},{"Done"}}, true)
	end
	
	if msg.text:lower() == "video>file" then
		users[userid].action = 15
		send_key(msg.from.id, "_Send now a_ *Video*\n`Maximum 5MB - 5000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "file>video" then
		users[userid].action = 16
		send_key(msg.from.id, "_Send now a_ *File*\n`Maximum 5MB - 5000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "video>gif" then
		users[userid].action = 17
		send_key(msg.from.id, "_Send now a_ *Video*\n`Maximum 3MB - 3000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "gif>video" then
		users[userid].action = 18
		send_key(msg.from.id, "_Send now a_ *Gif*\n`Maximum 3MB - 3000KB`", {{"Home"}}, true)
	end
	
	if msg.text:lower() == "audio>vioce" then
		users[userid].action = 19
		send_key(msg.from.id, "_Send now a_ *Audio*\n`Maximum 3MB - 3000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "voice>audio" then
		users[userid].action = 20
		send_key(msg.from.id, "_Send now a_ *Voice*\n`Maximum 3MB - 3000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>voice" then
		users[userid].action = 21
		send_key(msg.from.id, "_Send now_ *Text*\n`Maximum 300 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>audio" then
		users[userid].action = 22
		send_key(msg.from.id, "_Send now_ *Text*\n`Maximum 300 Characters`", {{"Home"}}, true)
	end
	
	if msg.text:lower() == "qr-code>text" then
		users[userid].action = 23
		send_key(msg.from.id, "_Send now a_ *QR Code Photo*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "qr-code>voice" then
		users[userid].action = 24
		send_key(msg.from.id, "_Send now a_ *QR Code Photo*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>qr-code" then
		users[userid].action = 25
		send_key(msg.from.id, "_Send now_ *Text*\n`Maximum 200 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>barcode" then
		users[userid].action = 26
		send_key(msg.from.id, "_Send now_ *Text*\n`Maximum 30 Char Number`", {{"Home"}}, true)
	end
	
	if msg.text:lower() == "text>font" then
		users[userid].action = 27
		send_key(msg.from.id, "_Send now_ *Words*\n`Maximum 30 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>style" then
		users[userid].action = 28
		send_key(msg.from.id, "_Send now_ *Text* _by_ *MarkDown* _format_\n`Maximum 4000 Characters`", {{"Home"},{"MarkDown Help","MarkDown Example"}}, true)
	elseif msg.text:lower() == "text>nashr" then
		users[userid].action = 31
		send_key(msg.from.id, "_Send now_ *Words*\n`Maximum 20 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>file" then
		users[userid].action = 32
		send_key(msg.from.id, "_Send now_ *Words*\n`Maximum 4000 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>hash-b64" then
		users[userid].action = 29
		send_key(msg.from.id, "_Send now_ *Text*\n`Maximum 200 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "hash-b64>text" then
		users[userid].action = 30
		send_key(msg.from.id, "_Send now_ *Hash Code*\n`Maximum 1000 Characters`", {{"Home"}}, true)
	end
	
	if users[userid].action > 0 then
		users[userid].sub = 1
		return save_data("users.json", users)
	else
		return send_key(msg.from.id, "_Input is_ *False,* _select a key of keyboard_", keyboard)
	end
end

return {launch = run}
-- apt-get instal imagemagick
