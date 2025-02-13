local M = {}

function M:peek(job)
    local start, cache = os.clock(), ya.file_cache(job)
	if not cache or self:preload(job) ~= 1 then
		return
	end

	ya.sleep(math.max(0, PREVIEW.image_delay / 1000 + start - os.clock()))
	ya.image_show(cache, job.area)
	ya.preview_widgets(job, {})
end

function M:seek(_) end

function M:preload(job)
	local cache = ya.file_cache(job)
	if not cache or fs.cha(cache) then
		return 1
	end

    local output = Command("sips")
            :args({"-g", "pixelHeight", "-g", "pixelWidth", tostring(job.file.url)})
            :stdout(Command.PIPED)
            :stderr(Command.PIPED)
            :output()

    if not output or not output.status.success then
        ya.err("sips-preview: failed to get size, error: " .. output.stderr.string)
        return 0
    end

    local height = tonumber(string.match(output.stdout, "pixelHeight: (%d+)"))
    local width = tonumber(string.match(output.stdout, "pixelWidth: (%d+)"))

    local max_width = (width / height) >= (PREVIEW.max_width / PREVIEW.max_height)

    local status, err = Command("sips"):args({
        "-s", "format", "jpeg",
        "-s", "formatOptions", tostring(PREVIEW.image_quality),
        max_width and "--resampleWidth" or "--resampleHeight",
        max_width and tostring(PREVIEW.max_width) or tostring(PREVIEW.max_height),
        tostring(job.file.url),
        "-o", tostring(cache)
    }):status()

    if status then
        return status.success and 1 or 0
    else
        ya.err("sips-preview: failed to convert, error: " .. err)
        return 0
    end
end

return M
